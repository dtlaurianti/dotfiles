return {
    {
        'nvim-telescope/telescope.nvim', version="0.1.4",
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
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
    -- view registers with ""
    'gennaro-tedesco/nvim-peekup',
    -- quick movement
    'ggandor/leap.nvim',
}
