return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = { border = "rounded", },
      },
    },
  },
  opts = {
    -- ensure_installed = require("user.languages").servers,
    -- automatic_installation = { exclude = { "rust_analyzer", "pylsp", "python-lsp-server" } },
  },
}
