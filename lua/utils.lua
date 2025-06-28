local utils = {}

--- Map a keybinding with sane defaults.
-- @param mode string|table: Mode(s) like 'n', 'i', 'v', etc.
-- @param lhs string: Keybind trigger
-- @param rhs string|function: Command or Lua function
-- @param opts table|nil: Extra options
utils.map = function(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

return utils
