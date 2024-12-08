return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
        },
      },
    },
  },
  opts = {
    ensure_installed = require("user.languages").servers,
    automatic_installation = { exclude = { "rust_analyzer", "pylsp" } },
  },
}
