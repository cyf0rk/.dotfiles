local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}
local lspkind = require("lspkind")
require('lspkind').init({
  mode = 'symbol_text',
})

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-q>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
        end
    },

	sources = {
    { name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = '..',
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function()
      Nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      Nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      Nnoremap("<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>")
			Nnoremap("[d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
			Nnoremap("]d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
      Nnoremap("<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
			Nnoremap("<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
			Nnoremap("<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    end,
	}, _config or {})
end

require("lspconfig").tsserver.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").html.setup(config())

require("lspconfig").emmet_ls.setup(config())

require("lspconfig").pyright.setup(config())

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
