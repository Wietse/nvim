local M = {}

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
    vim.notify("[lsp] Binary not found: " .. bin, vim.log.levels.WARN)
    return nil
  end
  return path
end

-- Shared on_attach callback for all LSPs
function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      noremap = true,
      desc = desc,
    })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gr", vim.lsp.buf.references, "Go to References")
  map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>a", vim.lsp.buf.code_action, "Code Action")
  -- map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

return M
