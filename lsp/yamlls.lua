local utils = require("utils")

-- Binary installed with:
--   `npm install -g yaml-language-server`
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
      format = { enable = true, bracketSpacing = true },
      validate = true,
      hover = true,
      completion = true,
      schemaStore = { enable = false },
      schemas = {
        ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
        ["/home/wja/projects/anet/anet-be/genfest/src/genfest/schema/scenario.schema.json"] = "*.scen.{yml,yaml}",
      },
    },
  },
}
