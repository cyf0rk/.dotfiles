return require('packer').startup(function(use)
    use'wbthomason/packer.nvim'
    use'mhartington/formatter.nvim'

    --use'TimUntersberger/neogit'

    -- telić
    use'nvim-lua/plenary.nvim'
    use'nvim-lua/popup.nvim'
    use'nvim-telescope/telescope.nvim'

    -- lsd
    use'neovim/nvim-lspconfig'
    use'hrsh7th/cmp-nvim-lsp'
    use'hrsh7th/cmp-buffer'
    use'hrsh7th/nvim-cmp'
    use {
        'tzachar/cmp-tabnine',
        run = './install.sh'
    }
    use'onsails/lspkind-nvim'
    use'nvim-lua/lsp_extensions.nvim'
    -- use'glepnir/lspsaga.nvim'
    use'L3MON4D3/LuaSnip'
    use'saadparwaiz1/cmp_luasnip'
    use'rafamadriz/friendly-snippets'

    -- undotee
    use'mbbill/undotree'

    -- quality pencils
    use'gruvbox-community/gruvbox'
    use'folke/tokyonight.nvim'
    use'chrisbra/Colorizer'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require'nvim-treesitter.install'.update({ with_sync = true })
        end,
    }
    use'nvim-treesitter/playground'
    use'romgrk/nvim-treesitter-context'

    -- bugs bunny
    use'mfussenegger/nvim-dap'
    use'mfussenegger/nvim-dap-python'
    use'rcarriga/nvim-dap-ui'
    use'theHamsta/nvim-dap-virtual-text'

    -- comments
    use'numToStr/Comment.nvim'
end)
