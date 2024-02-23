local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		'nvim-telescope/telescope.nvim', version="0.1.4",
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},
	{
		'folke/tokyonight.nvim',
		name = 'tokyonight',
		config = function()
			vim.cmd('colorscheme tokyonight')
		end
	},
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/playground',
        },
    },
	'theprimeagen/harpoon',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			--- manage LSP servers from neovim
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
		}
	},
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
			'hrsh7th/cmp-nvim-lsp',
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        }

    },
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
		config = function()
			require('lualine').setup()
		end
	},
	'lervag/vimtex',
	-- markdown preview
	-- install without yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- LuaSnip
    "saadparwaiz1/cmp_luasnip",
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    "rafamadriz/friendly-snippets",
})
