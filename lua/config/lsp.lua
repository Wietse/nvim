-- List of LSP servers to load
local servers = {
  "lua_ls",
  "pylsp",
  "ruff",
  "rust_analyzer",
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

-- -- Shared on_attach callback for all LSPs
-- local function on_attach(client, bufnr)
--   local map = function(mode, lhs, rhs, desc)
--     vim.keymap.set(mode, lhs, rhs, {
--       buffer = bufnr,
--       silent = true,
--       noremap = true,
--       desc = desc,
--     })
--   end
--
--   map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
--   map("n", "gr", vim.lsp.buf.references, "Go to References")
--   map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
--   map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
--   map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
--   map("n", "<leader>a", vim.lsp.buf.code_action, "Code Action")
--   -- map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
--
--   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
-- end

-- -- Call each LSP module, passing shared on_attach
-- for _, server in ipairs(servers) do
--   local ok, mod = pcall(require, "lsp." .. server)
--   if not ok then
--     vim.notify("[lsp] Failed to load server: " .. server, vim.log.levels.ERROR)
--   elseif type(mod) == "function" then
--     mod(on_attach)
--   end
-- end

vim.lsp.enable(servers)
