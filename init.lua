-- Enable Lua bytecode caching for faster startup and module loading
if vim.loader then vim.loader.enable() end

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("bootstrap-lazy")
require("config.lsp")
