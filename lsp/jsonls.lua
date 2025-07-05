local utils = require("utils")

-- Binary installed with:
--   `npm install -g vscode-json-languageserver`
local binary = utils.lsp_resolve_binary("vscode-json-languageserver")
if not binary then return end

return {
  cmd = { binary, "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  on_attach = utils.on_attach,
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
      schemaStore = { enable = true },
    },
  },
}
