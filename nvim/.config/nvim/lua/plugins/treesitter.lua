return {
  "romus204/tree-sitter-manager.nvim",
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require("tree-sitter-manager").setup({
      -- Default Options
      -- highlight = true, -- treesitter highlighting is enabled by default
      -- languages = {}, -- override or add new parser sources
      -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
      -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
      ensure_installed = {
          "markdown",
          "markdown_inline",
          "vimdoc",
          "javascript",
          "typescript",
          "c",
          "lua",
          "python",
          "go",
      },
      auto_install = true,
    })
  end
}
