local utils = require("utils")

-- Binary installed with:
--   `npm i yaml-language-server`
-- See: https://www.npmjs.com/package/yaml-language-server
local binary = utils.lsp_resolve_binary("yaml-language-server")
if not binary then return end

return {
  cmd = { binary, "--stdio" },
  filetypes = { "yaml", "yml" },
  root_markers = { ".git" },
  on_attach = utils.on_attach,
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      schemas = require("schemastore").yaml.schemas(),
      schemaStore = { enable = true },
    },
  },
}
