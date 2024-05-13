-- return {
--   "simrat39/rust-tools.nvim",
-- }

local vim = vim

return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  lazy = false, -- This plugin is already lazy
  ft = { "rust" },
  opts = {
    server = {
      on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set
        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
        keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "gl", vim.diagnostic.open_float, opts)
        keymap("n", "]d", vim.diagnostic.goto_next, opts)
        keymap("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap("n", "<leader>a", vim.cmd.RustLsp("codeAction"), opts)
        keymap("n", "<leader>r", vim.lsp.buf.rename, opts)
        keymap("n", "<leader>s", vim.lsp.buf.signature_help, opts)
        keymap("n", "<leader>f", vim.lsp.buf.format, opts)
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          -- Add clippy lints for Rust.
          checkOnSave = {
            allFeatures = true,
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
        },
      },
    }
  },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
  end
}
