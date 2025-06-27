-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Initialize Lazy
require("lazy").setup({
  spec = {
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    colorscheme = { "ellisonleao/gruvbox.nvim", "default" },
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  ui = {
    border = "rounded",
  },
})



-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- local plugins = {
--   -- Colorscheme:
--   'gruvbox-community/gruvbox',
--
--   -- Interaction with tmux
--   'alexghergh/nvim-tmux-navigation',
--
--   -- Cute UI
--   {
--     'nvim-lualine/lualine.nvim',
--     dependencies = { 'nvim-tree/nvim-web-devicons' }
--   },
--
--   -- Git integration
--   'tpope/vim-fugitive',
--
--   -- Commenting code
--   'tomtom/tcomment_vim',
--
--   -- Fuzzy finder
--   {
--     'nvim-lua/telescope.nvim', tag = '0.1.5',
--     dependencies = {
--       {'nvim-lua/popup.nvim'},
--       {'nvim-lua/plenary.nvim'},
--       {'jremmen/vim-ripgrep'},
--       {'sharkdp/fd'},
--     }
--   },
--
--   -- Treesitter syntax highlighting
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		build = ":TSUpdate",
-- 	},
--
--   -- LSP
--   -- https://github.com/VonHeikemen/lsp-zero.nvim
--   -- https://github.com/williamboman/mason.nvim
--   {
--     'VonHeikemen/lsp-zero.nvim',
--     dependencies = {
--       -- LSP Support
--       {'neovim/nvim-lspconfig'},
--       {'williamboman/mason.nvim'},
--       {'williamboman/mason-lspconfig.nvim'},
--
--       -- Autocompletion
--       {'hrsh7th/nvim-cmp'},
--       {'hrsh7th/cmp-buffer'},
--       {'hrsh7th/cmp-path'},
--       {'saadparwaiz1/cmp_luasnip'},
--       {'hrsh7th/cmp-nvim-lsp'},
--       {'hrsh7th/cmp-nvim-lsp-signature-help'},
--       {'hrsh7th/cmp-nvim-lua'},
--       {'hrsh7th/vim-vsnip'},
--
--       -- Snippets
--       {'L3MON4D3/LuaSnip'},
--       {'rafamadriz/friendly-snippets'},
--     }
--   },
--
--   'simrat39/rust-tools.nvim',
--
-- }


-- -- Bootstrap lazy.nvim
--
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--
-- if not vim.loop.fs_stat(lazypath) then
--   print('lazypath does not exist')
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
--
-- vim.opt.rtp:prepend(lazypath)
--
-- -- Use a protected call so we don't error out on first use
-- local status_ok, lazy = pcall(require, 'lazy')
-- if not status_ok then
--   print('unable to load lazy!')
--   return
-- end
--
-- -- Start setup
-- lazy.setup(plugins)
