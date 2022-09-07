vim.opt.list = true
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'eol:↴'
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#2e2e2e gui=nocombine]]
vim.cmd [[highlight IndentBlanklineSpaceCharBlankline guifg=#2e2e2e gui=nocombine]]

require'indent_blankline'.setup {
    viewport_buffer = 100,
    char = '',
    show_trailing_blankline_indent = false,
    filetype_exclude = {
        "vimwiki",
        "man",
        "gitmessengerpopup",
        "diagnosticpopup",
        "lspinfo",
        "packer",
        "checkhealth",
        "TelescopePrompt",
        "TelescopeResults",
        "",
    },
    buftype_exclude = { "terminal" },
    space_char_blankline = " ",
    show_foldtext = false,
    strict_tabs = true,
    debug = true,
    disable_with_nolist = true,
    max_indent_increase = 1,
    use_treesitter_scope = true,
}
