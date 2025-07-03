local utils = require("utils")

local binary = utils.lsp_resolve_binary("ruff")
if not binary then return end

return {
  cmd = { binary },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
  on_attach = utils.on_attach,

  settings = {
    configuration = "/home/wja/projects/dotfiles/python/ruff.toml", -- Custom config for ruff to use
    lint = {
      preview = true,
    },
  },
}
