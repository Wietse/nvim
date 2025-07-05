local utils = require("utils")

-- Binary installed with:
--   `npm i -g bash-language-server`
-- See: https://github.com/bash-lsp/bash-language-server
local binary = utils.lsp_resolve_binary("bash-language-server", "bashls")
if not binary then return end

return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  on_attach = utils.on_attach,
}
