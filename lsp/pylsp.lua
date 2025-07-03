return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
  on_attach = require("utils").on_attach,

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
