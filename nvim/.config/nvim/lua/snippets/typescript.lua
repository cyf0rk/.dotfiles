
-- DOCS:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snippets
--
-- GLOBAL VARS:
-- https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104§

local session = require("luasnip.session")

local env = session.config.snip_env
local s = env["s"]
local t = env["t"]
local i = env["i"]

return {
    s({ trig = "co", name = "Constant", dscr = "Insert a constant" }, {
        t("const "),
        i(1, "name"),
        t(" = "),
        i(2, "value"),
    }),

    s({ trig = "le", name = "Mutable variable", dscr = "Insert a mutable variable" }, {
        t("let "),
        i(1, "name"),
        t(" = "),
        i(2, "value"),
    }),

    s(
        {
            trig = "clg",
            name = "Console log",
            dscr = "Insert a console log",
        },
        {
            t('console.log('),
            i(1, "value"),
            t(')'),
        }
    ),
}
