-- Setup nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    luasnip = "[Snip]",
    path = "[Path]",
}
local lspkind = require("lspkind")
require('lspkind').init({
    mode = 'symbol_text',
})

require("luasnip.loaders.from_vscode").lazy_load()

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-q>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = source_mapping[entry.source.name]
            return vim_item
        end
    },

    sources = {
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },

    window = {
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },

    experimental = {
        ghost_text = false,
        native_menu = false,
    },
}

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
