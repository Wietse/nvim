-- Enable Lua bytecode caching for faster startup and module loading
if vim.loader then vim.loader.enable() end

require("lua.config.options")
require("lua.config.keymaps")
require("lua.config.autocmds")
require("lua.bootstrap-lazy")
