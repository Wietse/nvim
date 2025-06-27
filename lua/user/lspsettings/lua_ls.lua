return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Recognize `vim` as a global
      },
      workspace = {
        checkThirdParty = false, -- Don't prompt about third-party libraries
      },
      telemetry = { enable = false }, -- optional
    }
  }
}
