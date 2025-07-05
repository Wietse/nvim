local M = {}

-- Logging functions
function M.info(msg, title) vim.notify(msg, vim.log.levels.INFO, { title = title or "LSP" }) end
function M.warn(msg, title) vim.notify(msg, vim.log.levels.WARN, { title = title or "LSP" }) end
function M.error(msg, title) vim.notify(msg, vim.log.levels.ERROR, { title = title or "LSP" }) end

--- Map a keybinding with sane defaults.
-- @param mode string|table: Mode(s) like 'n', 'i', 'v', etc.
-- @param lhs string: Keybind trigger
-- @param rhs string|function: Command or Lua function
-- @param opts table|nil: Extra options
M.map = function(mode, lhs, rhs, opts, desc)
  local options = { silent = true }
  if desc then options.desc = desc end
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

--- Check if executable exists, return full path or nil
function M.resolve_binary(bin)
  if bin:find("^~") or bin:find("%$") then bin = vim.fn.expand(bin) end
  local path = vim.fn.exepath(bin)
  if path == "" then
    M.warn("[lsp] Binary not found: " .. bin)
    return nil
  end
  return path
end

-- LSP binary specific convenience check
function M.lsp_resolve_binary(bin, label)
  if not label then label = bin end
  local binary = M.resolve_binary(bin)
  if not binary then
    M.warn(bin .. " binary not found", label)
    return
  end
  -- vim.schedule(function() M.info('✅ Starting LSP "' .. label .. '" with binary: ' .. binary) end)
  return binary
end

-- Shared on_attach callback for all LSPs
---@diagnostic disable-next-line:unused-local
function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      noremap = true,
      desc = desc,
    })
  end

  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show Definitions")
  map("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", "Show Type Definitions")
  map("n", "gr", "<cmd>Telescope lsp_references<CR>", "Show References")
  map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>a", vim.lsp.buf.code_action, "Code Action")
  -- map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  map(
    "n",
    "gl",
    "<cmd>lua vim.diagnostic.open_float({scope='cursor'})<CR>",
    "Open diagnostics at cursor in a floating window"
  )
  map("n", "]d", "<cmd>lua vim.diagnostic.jump({count=1, float=true})<CR>", "Goto Next Diagnostic")
  map("n", "[d", "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<CR>", "Goto Prev Diagnostic")

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

return M
