local utils = require("utils")

-- Binary installed with:
--   `npm i -g vscode-langservers-extracted`
-- See: https://github.com/hrsh7th/vscode-langservers-extracted
local binary = utils.lsp_resolve_binary("vscode-html-language-server")
if not binary then return end

return {
  cmd = { binary, "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  on_attach = utils.on_attach,
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}
