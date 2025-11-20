return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      -- Adds endwise functionality
      "RRethy/nvim-treesitter-endwise",
      -- Adds smart matching
      "andymass/vim-matchup",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = require("config.constants").parsers,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },

        matchup = {
          enable = true, -- vim-matchup integration
        },

        endwise = {
          enable = true,
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- automatically jump forward to textobj
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              -- add more if needed
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
