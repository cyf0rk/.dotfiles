local cmp = require'cmp'
local luasnip = require'luasnip'
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    luasnip = "[Snip]",
    path = "[Path]",
}
local lspkind = require'lspkind'

lspkind.init({
    mode = 'symbol_text',
})

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
        fields = { 'kind', 'abbr', 'menu' },
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,

            before = function(entry, vim_item)
                vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                vim_item.menu = source_mapping[entry.source.name]
                return vim_item
            end
        })
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
    max_num_results = 10,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
})
