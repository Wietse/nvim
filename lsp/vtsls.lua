local utils = require("utils")

-- Binary installed with:
--   `npm install -g @vtsls/language-server`
-- See: https://github.com/yioneko/vtsls
local binary = utils.lsp_resolve_binary("vtsls")
if not binary then return end

return {
  cmd = { binary, "--stdio" },
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
  },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  on_attach = utils.on_attach,
}
