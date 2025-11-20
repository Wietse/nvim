return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gstatus", "Gdiffsplit", "Gwrite", "Gread", "Gblame", "Gbrowse" },
    keys = {
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
      { "<leader>gd", "<cmd>Gdiffsplit!<CR>", desc = "Git diff (3-way)" },
      { "<leader>gB", "<cmd>Gbrowse<CR>", desc = "Open in GitHub" },
    },
    config = function()
      -- Optional: Use traditional buffer for blame (not virtual)
      vim.g.fugitive_blame_use_virtual = false

      -- Autocmds for Fugitive buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fugitive", "fugitiveblame" },
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
    end,
  },

  -- Optional: GitHub integration for :Gbrowse
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
    event = "VeryLazy",
  },

  -- Minimal gitsigns to visulalize and allow moving between hunks
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        current_line_blame = false,

        -- on_attach = function(bufnr)
        --   -- Skip attaching in diff mode
        --   if vim.wo.diff then return end
        --
        --   local map = function(mode, lhs, rhs, desc)
        --     vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        --   end
        --
        --   map("n", "]c", function() require("gitsigns").next_hunk() end, "Next Git hunk")
        --   map("n", "[c", function() require("gitsigns").prev_hunk() end, "Prev Git hunk")
        -- end,
      })
    end,
  },
}
