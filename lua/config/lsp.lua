-- List of LSP servers to load
local servers = {
  "bashls",
  "dockerls",
  "htmlls",
  "jsonls",
  "lua_ls",
  "marksman",
  "pylsp",
  "ruff",
  "rust_analyzer",
  "sqruff",
  "vtsls",
  "yamlls",
}

-- Set custom diagnostic signs and options
local icons = require("config.icons")

-- Apply diagnostic config globally
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error or "E",
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning or "W",
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Information or "I",
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint or "H",
    },
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- Optional: Set rounded borders for LSP windows
vim.lsp.util.open_floating_preview = (function(orig)
  return function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
  end
end)(vim.lsp.util.open_floating_preview)

vim.lsp.enable(servers)
