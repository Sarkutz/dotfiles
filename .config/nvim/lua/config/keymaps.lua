-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- <C-c>: copy to system clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- snippet expansion on visual selection
-- vim.keymap.set("x", "<C-k>", function()
--   -- get visual selection
--   local text = vim.fn.getreg('"')
--   vim.snippet.expand(text)
-- end, { desc = "Expand snippet from visual selection" })
