local utils = require("utils")

-- Binary installed with:
--   `sudo snap install marksman`
-- See: https://github.com/artempyanykh/marksman
local binary = utils.lsp_resolve_binary("marksman")
if not binary then return end

return {
  cmd = { binary, "server" },
  filetypes = { "markdown" },
  root_markers = { ".git" },
  on_attach = utils.on_attach,
}
