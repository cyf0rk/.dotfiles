return require('packer').startup(function()
	use('wbthomason/packer.nvim')
	use('sbdchd/neoformat')

	--use('TimUntersberger/neogit')

	-- telić
	use('nvim-lua/plenary.nvim')
	use('nvim-lua/popup.nvim')
	use('nvim-telescope/telescope.nvim')

	-- lsd
	use('neovim/nvim-lspconfig')
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-buffer')
	use('hrsh7th/nvim-cmp')
	use({'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp'})
	use('onsails/lspkind-nvim')
	use('nvim-lua/lsp_extensions.nvim')
	use('glepnir/lspsaga.nvim')
	use('simrat39/symbols-outline.nvim')
	use('L3MON4D3/LuaSnip')
	use('saadparwaiz1/cmp_luasnip')

	-- undotee
	use('mbbill/undotree')

	-- quality pencils
	use('gruvbox-community/gruvbox')
	use('folke/tokyonight.nvim')

	use('nvim-treesitter/nvim-treesitter', {
	run = ':TSUpdate'
	})
	use('nvim-treesitter/playground')
	use('romgrk/nvim-treesitter-context')

	-- defak
	use('mfussenegger/nvim-dap')
	use('rcarriga/nvim-dap-ui')
	use('theHamsta/nvim-dap-virtual-text')

	-- comments
	use('tpope/vim-commentary')

    -- nice nvim status line
    use('itchyny/lightline.vim')

    -- spider web stuff
    use('mattn/emmet-vim')
end)
