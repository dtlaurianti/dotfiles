" Call the init.lua configuration file from a different location
lua << EOF
  vim.cmd([[source ~/.config/nvim/init.lua]])  -- Adjust path as needed
EOF
