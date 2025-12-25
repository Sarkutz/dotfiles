-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- text
-- ----
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    vim.bo.smartindent = false
    -- Enable gq
    vim.bo.formatexpr = ""
    vim.bo.textwidth = 78
  end,
})

-- rst
-- ---
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rst" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 3
    vim.bo.shiftwidth = 3
    vim.bo.softtabstop = 3
    vim.bo.smartindent = false
    -- Enable gq
    vim.bo.formatexpr = ""
    vim.bo.textwidth = 78
  end,
})

-- markdown
-- --------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Enable gq
    vim.bo.formatexpr = ""
    vim.bo.textwidth = 80
    vim.bo.formatoptions = "tcqron" -- key part: no 'a', no '2nd line' auto bullets
    vim.bo.comments = "b:* ,b:- ,b:+ ,n:>" -- note the space after the bullet!
  end,
})

-- C/C++
-- -----
-- Use LSP instead?
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "c", "cpp", "h" },
--   callback = function()
--     vim.bo.expandtab = false
--     vim.bo.tabstop = 8
--     vim.bo.shiftwidth = 8
--     vim.bo.softtabstop = 8
--     vim.bo.textwidth = 78
--   end,
-- })

-- msg
-- ---
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.msg",
  callback = function()
    vim.bo.filetype = "msg"
  end,
})

-- cli
-- ---
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.cli",
  callback = function()
    vim.bo.filetype = "cli"
  end,
})

-- sh
-- --
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "sh" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    -- Disable autoformat
    vim.b.autoformat = false
  end,
})
