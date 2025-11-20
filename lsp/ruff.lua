local utils = require("utils")

local binary = utils.lsp_resolve_binary("ruff")
if not binary then return end

return {
  cmd = { binary, "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.cfg", ".git" },
  on_attach = utils.on_attach,
  settings = {
    lint = {
      preview = true,
    },
  },
}
