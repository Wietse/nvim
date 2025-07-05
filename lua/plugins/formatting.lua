return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        -- Automatically format on save
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },

        -- Formatter config per filetype
        formatters_by_ft = {
          bash = { "shfmt" },
          sh = { "shfmt" },
          lua = { "stylua" },
          python = { "ruff" },
          rust = { "rustfmt" },
        },

        -- Optionally override formatters
        formatters = {
          ruff = {
            -- Optional: ensure it uses stdin for best performance
            args = { "format", "-" },
            stdin = true,
          },
        },
      })

      -- Normal mode keymap: format the whole buffer
      vim.keymap.set(
        "n",
        "<leader>f",
        function()
          require("conform").format({
            lsp_fallback = true,
            async = true,
          })
        end,
        { desc = "Format buffer" }
      )

      -- Visual mode keymap: format selection
      vim.keymap.set(
        "v",
        "<leader>f",
        function()
          require("conform").format({
            lsp_fallback = true,
            async = true,
          })
        end,
        { desc = "Format selection" }
      )
    end,
  },
}
