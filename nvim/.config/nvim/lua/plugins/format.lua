return {
  'mhartington/formatter.nvim',
  config = function()
    local vim = vim
    local formatter = require'formatter'
    local prettierConfig = function()
      return {
        exe = 'prettier',
        args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
        stdin = true
      }
    end

    local formatterConfig = {
      lua = {
        function()
          return {
            exe = 'stylua',
            args = {'-'},
            stdin = true,
          }
        end,
      },
      python = {
        function()
          return {
            -- Black
            exe = 'black',
            args = {'-'},
            stdin = true
          }
        end
      },
      ["*"] = {
        function()
          return {
            -- remove trailing whitespace
            exe = 'sed',
            args = {'-i', "'s/[ \t]*$//'"},
            stdin = false
          }
        end
      }
    }
    local commonFT = {
      "css",
      "scss",
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "markdown",
      "markdown.mdx",
      "json",
      "yaml",
      "xml",
      "svg",
      "svelte",
      "go",
      "lua"
    }
    for _, ft in ipairs(commonFT) do
      formatterConfig[ft] = {prettierConfig}
    end
    -- Setup functions
    formatter.setup(
      {
        logging = true,
        filetype = formatterConfig,
        log_level = 2,
      }
    )
  end
}
