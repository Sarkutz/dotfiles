return {
  "jpalardy/vim-slime",
  init = function()
    -- Disable Slime's default key mappings
    vim.g.slime_no_mappings = 1

    -- Set Slime target to tmux
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = {
      socket_name = "default",
      target_pane = "{last}",
    }

    vim.g.slime_preserve_curpos = 0
  end,
  keys = {
    { "<C-I>", "<Plug>SlimeLineSendj", mode = "n", desc = "Send (slime)" },
    { "<C-I>", "<Plug>SlimeRegionSend}", mode = "x", desc = "Send (slime)" },
    { "<leader>ue", "<Plug>SlimeConfig", mode = "n", desc = "config (slimE)" },
  },
}
