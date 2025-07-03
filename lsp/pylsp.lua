local utils = require("utils")

local binary = utils.lsp_resolve_binary("pylsp")
if not binary then return end

return {
  cmd = { binary },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
  on_attach = utils.on_attach,

  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        pyflakes = { enabled = false },
        rope = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        black = { enabled = false },
        ruff = { enabled = false },
        mypy = {
          enabled = true,
          live_mode = true,
          strict = true,
        },
      },
    },
  },
}
