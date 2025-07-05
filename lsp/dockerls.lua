local utils = require("utils")

-- Binary installed with:
--   `go install github.com/docker/docker-language-server/cmd/docker-language-server@latest`
-- See: https://github.com/docker/docker-language-server
local binary = utils.lsp_resolve_binary("docker-language-server", "bashls")
if not binary then return end

return {
  cmd = { "docker-language-server", "start", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile" },
  on_attach = utils.on_attach,
}
