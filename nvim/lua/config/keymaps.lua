-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Maps <F5> in normal mode to save the file and execute it via python3
vim.keymap.set("n", "<F5>", "<cmd>w<CR><cmd>!python3 %<CR>", { desc = "Save and Run Python file" })
