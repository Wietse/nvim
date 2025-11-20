local utils = require("utils")

-- Binary installed with:
--   `npm install -g vscode-json-languageserver`
local binary = utils.lsp_resolve_binary("vscode-json-languageserver", "jsonls")
if not binary then return end

-- --Enable (broadcasting) snippet capability for completion
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  cmd = { binary, "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  -- capabilities = capabilities,
  on_attach = utils.on_attach,
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
      schemaStore = { enable = true },
      format = { enable = true },
    },
  },
}
