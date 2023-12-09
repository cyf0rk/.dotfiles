return require('packer').startup(function(use)
    use'wbthomason/packer.nvim'

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.4',
      -- or                          , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use'theprimeagen/harpoon'
    use {
        'nvim-treesitter/nvim-treesitter',
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
    -- git
    use'tpope/vim-fugitive'
    -- comments
    use'numToStr/Comment.nvim'
    -- format
    use'mhartington/formatter.nvim'
    -- marinade in code
    use'folke/zen-mode.nvim'
    use'github/copilot.vim'
    -- bugs bunny
    -- use'mfussenegger/nvim-dap'
    -- use'mfussenegger/nvim-dap-python'
    -- use'rcarriga/nvim-dap-ui'
    -- use'theHamsta/nvim-dap-virtual-text'
end)
