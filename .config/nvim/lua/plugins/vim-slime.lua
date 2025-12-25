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
  end,
  keys = {
    { "<leader>t", "", desc = "+text" },
    { "<leader>ts", "<Plug>SlimeLineSend", mode = "n", desc = "Send (slime)" },
    { "<leader>ts", "<Plug>SlimeRegionSend", mode = "x", desc = "Send (slime)" },
    { "<leader>tsc", "<Plug>SlimeConfig", mode = "n", desc = "Config (slime)" },
  },
}
