local utils = require("utils")

-- Binary installed with
--   `rustup component add rust-analyzer`
local binary = utils.lsp_resolve_binary("rust-analyzer")
if not binary then return end

return {
  cmd = { binary },
  filetypes = { "rust" },
  root_markers = { ".git", "Cargo.toml" },
  on_attach = utils.on_attach,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
