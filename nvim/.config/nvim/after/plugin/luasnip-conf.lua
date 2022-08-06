local ls = require "luasnip"
local types = require "luasnip.util.types"

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
}

-- Extend with vs-code style snippets (https://github.com/rafamadriz/friendly-snippets)
ls.filetype_extend("html", {})
ls.filetype_extend("shell", {})
ls.filetype_extend("gitcommit", {})
ls.filetype_extend("markdown", {})
ls.filetype_extend("css", {})
ls.filetype_extend("python", {})
ls.filetype_extend("javascript", {})
ls.filetype_extend("typescript", {})
require("luasnip.loaders.from_vscode").lazy_load()
