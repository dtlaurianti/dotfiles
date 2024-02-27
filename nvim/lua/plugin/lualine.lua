return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    config = function()
        require('lualine').setup({
            sections = {
                lualine_c = { { 'filename', file_status = true, path = 1 } }
            },
        })
    end
}
