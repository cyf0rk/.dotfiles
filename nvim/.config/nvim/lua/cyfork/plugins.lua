local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {
    'wbthomason/packer.nvim',

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        -- or                          , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'theprimeagen/harpoon',
        branch = "harpoon2"
    },
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-treesitter/nvim-treesitter'}
        }
    },
    -- treeshitter
    {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.2',
        build = function()
            require'nvim-treesitter.install'.update({ with_sync = true })
        end,
    },
    'nvim-treesitter/playground',
    'romgrk/nvim-treesitter-context',
    -- go
    'ray-x/go.nvim',
    'ray-x/guihua.lua',
    -- undotee
    'mbbill/undotree',
    -- quality pencils
    {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },
    'folke/tokyonight.nvim',
    'chrisbra/Colorizer',
    -- lsd
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },
    {
        'folke/trouble.nvim',
        dependencies = { {'nvim-tree/nvim-web-devicons'} },
        lazy = {},
    },
    -- linting
    'mfussenegger/nvim-lint',
    -- git
    'tpope/vim-fugitive',
    -- comments
    'numToStr/Comment.nvim',
    -- format
    'mhartington/formatter.nvim',
    -- marinade in code
    'github/copilot.vim',
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            {'zbirenbaum/copilot.lua'},
            {'nvim-lua/plenary.nvim'},
        },
        branch = "canary",
        lazy = {
            debug = true,
        },
    },

    -- practice vim
    'ThePrimeagen/vim-be-good',

    -- note taking
    {
        "epwalsh/obsidian.nvim",
        tag = "*",  -- recommended,  latest release instead of latest commit
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- bugs bunny
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'ray-x/guihua.lua',

            -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',

            -- Add your own debuggers here
            'leoluz/nvim-dap-go',
            'nvim-neotest/nvim-nio',
            'mfussenegger/nvim-dap-python',
            'ray-x/go.nvim',
        }
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
