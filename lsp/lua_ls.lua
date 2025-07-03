local utils = require("utils")

local binary =
  utils.resolve_binary("~/software/lua-language-server-3.15.0-linux-x64/bin/lua-language-server")
if not binary then return end

print("[lua_ls] Starting LSP with binary: " .. binary)

return {
  cmd = { binary },
  root_markers = { ".git", ".luarc.json", "lua" },
  filetypes = { "lua" },
  on_attach = utils.on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = { enable = false },
    },
  },
}
