-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_create_user_command('Ruff', function()
  vim.cmd('!ruff check .')  -- Run ruff using the pyproject.toml for configuration
end, {})

vim.api.nvim_create_user_command('RuffFix', function()
  vim.cmd('!ruff check . --fix')  -- Run ruff using the pyproject.toml for configuration
end, {})
