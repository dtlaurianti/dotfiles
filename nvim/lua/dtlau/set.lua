-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab sizing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- line wrapping
vim.opt.wrap = false

-- long undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- highlight while typing search
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- view 8 lines above cursor
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update
vim.opt.updatetime = 50

-- visual color for 80 char
vim.opt.colorcolumn = "80"

-- <leader> is space
vim.g.mapleader = " "

-- tilde on lines that don't exist
vim.opt.fillchars = { eob = '~' }
