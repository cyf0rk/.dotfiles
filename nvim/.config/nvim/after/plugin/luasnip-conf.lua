if vim.g.snippets == "luasnip" then
    return
end
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

ls.config.setup({ store_selection_keys = "<A-p>" })
