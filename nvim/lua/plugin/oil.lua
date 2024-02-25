return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require("oil").setup({
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-p>"] = "actions.preview",
                ["<C-r>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g\\"] = "actions.toggle_trash",
            },
            -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
            delete_to_trash = true,
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = false,
            -- Set to true to watch the filesystem for changes and reload oil
            experimental_watch_for_changes = true,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
            },
        })
    end
}
