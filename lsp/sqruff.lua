local utils = require("utils")

-- Binary installed in the nvim-py3.12 environment with:
--   `pip install sqruff`
-- with a symlink in ~/.local/bin
-- Configuration is best done in a `.sqruff` file,
-- see: https://github.com/quarylabs/sqruff
local binary = utils.lsp_resolve_binary("sqruff")
if not binary then return end

return {
  cmd = { binary, "lsp" },
  filetypes = { "sql" },
  root_markers = { ".sqruff", ".git" },
  on_attach = utils.on_attach,
}
