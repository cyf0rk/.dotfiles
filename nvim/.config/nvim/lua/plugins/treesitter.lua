return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local ts = require("nvim-treesitter")
        ts.setup({})
        local ensure_installed = {
            -- go
            "go", "gomod", "gosum", "gowork",
            -- python
            "python",
            -- php
            "php", "phpdoc",
            -- js/ts/react/vue/htmx (html covers htmx attributes)
            "javascript", "typescript", "tsx", "vue", "html", "css",
            -- rust
            "rust",
            -- bash
            "bash",
            -- data/config formats
            "json", "yaml", "toml",
            -- docs
            "markdown", "markdown_inline",
            -- misc / editing quality of life
            "lua", "vim", "vimdoc", "query", "regex",
            "dockerfile", "sql", "graphql",
            "gitcommit", "gitignore", "diff",
        }

        local installed = ts.get_installed and ts.get_installed("parsers") or {}
        local to_install = vim.tbl_filter(function(lang)
            return not vim.list_contains(installed, lang)
        end, ensure_installed)

        if #to_install > 0 then
            ts.install(to_install)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match) or args.match
                if not pcall(vim.treesitter.start, args.buf, lang) then
                    return
                end

                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
