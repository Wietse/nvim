local utils = require("utils")

local binary = utils.lsp_resolve_binary("pylsp")
if not binary then return end

return {
  cmd = { binary },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
  on_attach = utils.on_attach,

  -- Don't activate for fugitive/diff buffers
  root_dir = function(bufnr, on_dir)
    if utils.is_fugitive_buf(bufnr) then return end

    local name = vim.api.nvim_buf_get_name(bufnr)
    if name:match("^file://") then
      local ok, path = pcall(vim.uri_to_fname, name)
      if ok and path and path ~= "" then name = path end
    end
    if not vim.uv.fs_stat(name) then return end

    local root = vim.fs.root(
      bufnr,
      { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" }
    ) or vim.uv.cwd()
    if root and root ~= "" and not root:match("^%.%/?$") then on_dir(vim.fs.normalize(root)) end
  end,

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
