-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true

-- Undercurl
-- TODO This does not work yet, need to tweak terminal.
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Set LazyRoot to cwd
vim.g.root_spec = { "cwd" }

vim.opt.swapfile = false
