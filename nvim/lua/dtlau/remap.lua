-- map space to <leader>
vim.g.mapleader = " "

-- go to netrw explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- maintain cursor centeredness
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without losing buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete with losing buffer
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- popup virtual error message
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")

-- prettier format
function PrettierFormat()
  vim.cmd ':w!'
  vim.cmd '!npx prettier --write %'
  vim.cmd ':e'
end

vim.keymap.set("n", "<leader>f", PrettierFormat, { noremap = true })
