return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "Kaiser-Yang/blink-cmp-dictionary",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    "mgalliou/blink-cmp-tmux",
  },
  opts = {
    -- The default preset keymap does not bind <CR>
    keymap = { preset = "default" },
    completion = {
      ghost_text = {
        enabled = true,
      },
      menu = {
        -- Unobstrusive menu
        auto_show = false,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        -- Unobstrusive documentation
        -- Use C-space on menu to show
        auto_show = false,
      },
    },
    sources = {
      default = { "lsp", "snippets", "buffer", "path", "tmux" },
      per_filetype = {
        text = { inherits_defaults = true, "dictionary" },
        rst = { inherits_defaults = true, "dictionary" },
        markdown = { inherits_defaults = true, "dictionary" },
      },
      providers = {
        -- lsp = {
        --   https://cmp.saghen.dev/configuration/sources.html#show-buffer-completions-with-lsp
        --   fallbacks = {},
        -- },
        dictionary = {
          name = "dict",
          -- https://github.com/Kaiser-Yang/blink-cmp-dictionary
          module = "blink-cmp-dictionary",
          min_keyword_length = 4,
          max_items = 5,
          opts = {
            dictionary_files = {
              -- Source of dictionary: https://github.com/dwyl/english-words
              vim.fn.expand("/home/ashim/.config/nvim/dictionary/words.txt"),
              vim.fn.expand("/home/ashim/.config/nvim/dictionary/ashim.txt"),
            },
          },
        },
        tmux = {
          name = "tmux",
          -- https://github.com/mgalliou/blink-cmp-tmux
          module = "blink-cmp-tmux",
          min_keyword_length = 4,
          max_items = 8,
          opts = {
            all_panes = true,
            capture_history = true,
            -- triggered_only = false,
            -- trigger_chars = { "." }
          },
        },
      },
    },
    -- Experimental feature?
    signature = {
      enabled = true,
      -- window = { show_documentation = false },
    },
    -- cmdline = {
    --   enabled = true,
    --   completion = {
    --     ghost_text = {
    --       enabled = true,
    --     },
    --   },
    -- },
    -- term = {
    --   enabled = false,
    -- },
  },
}
