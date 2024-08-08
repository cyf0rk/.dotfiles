return require('packer').startup(function(use)
    use'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                          , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'theprimeagen/harpoon',
        branch = "harpoon2"
    }
    use {
        'ThePrimeagen/refactoring.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-treesitter/nvim-treesitter'}
        }
    }
    -- treeshitter
    use {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.2',
        run = function()
            require'nvim-treesitter.install'.update({ with_sync = true })
        end,
    }
    use'nvim-treesitter/playground'
    use'romgrk/nvim-treesitter-context'
    -- undotee
    use'mbbill/undotree'
    -- quality pencils
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    use'folke/tokyonight.nvim'
    use'chrisbra/Colorizer'
    -- lsd
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
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
    }
    use({
        'folke/trouble.nvim',
        requires = { {'nvim-tree/nvim-web-devicons'} },
        opts = {},
    })
    -- linting
    use'mfussenegger/nvim-lint'
    -- git
    use'tpope/vim-fugitive'
    -- comments
    use'numToStr/Comment.nvim'
    -- format
    use'mhartington/formatter.nvim'
    -- marinade in code
    use'github/copilot.vim'
    use {
        'CopilotC-Nvim/CopilotChat.nvim',
        requires = {
            {'zbirenbaum/copilot.lua'},
            {'nvim-lua/plenary.nvim'},
        },
        branch = "canary",
        opts = {
            debug = true,
        },
    }

    -- practice vim
    use'ThePrimeagen/vim-be-good'

    -- note taking
    use({
      "epwalsh/obsidian.nvim",
      tag = "*",  -- recommended, use latest release instead of latest commit
      requires = { "nvim-lua/plenary.nvim" },
    })

    -- bugs bunny
    use({
        'mfussenegger/nvim-dap',
        requires = {
            -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'ray-x/guihua.lua',

            -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',

            -- Add your own debuggers here
            'leoluz/nvim-dap-go',
            'mfussenegger/nvim-dap-python',
            'ray-x/go.nvim',
          }
    })
end)
