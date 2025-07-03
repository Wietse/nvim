-- Bootstrap lazy.nvim
-- Use Neovim's built-in path joining for cross-platform safety
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

-- Check if Lazy.nvim is installed
---@diagnostic disable-next-line:undefined-field
if not vim.uv.fs_stat(lazypath) then
  local result = vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
    :wait()

  if result.code ~= 0 then
    vim.api.nvim_echo({
      { "❌ Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { result.stderr or "(no error message)", "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Safely load Lazy
local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.api.nvim_echo({ "Failed to load lazy.nvim" }, true, { err = true })
  return
end

-- Setup Lazy.nvim
lazy.setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = false, -- load custom plugins eagerly
    version = false, -- always use the latest commit
  },
  install = {
    colorscheme = { "ellisonleao/gruvbox.nvim", "default" },
  },
  checker = {
    enabled = true, -- background plugin update checks
    notify = false,
  },
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
    profiling = {
      -- Measure plugin loading times when NVIM_LAZY_PROFILE env var is set to "1"
      loader = vim.env.NVIM_LAZY_PROFILE == "1",
      reset_packpath = true, -- Clean up unused paths
    },
  },
})

vim.schedule(function() vim.notify("✅ Lazy.nvim loaded and configured", vim.log.levels.INFO) end)
