-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Initialize Lazy
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
  install = {
    colorscheme = { "ellisonleao/gruvbox.nvim", "default" },
  },
  ui = {
    border = "rounded",
  },
})



-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

local plugins = {
  -- Colorscheme:
  'gruvbox-community/gruvbox',

  -- Interaction with tmux
  'alexghergh/nvim-tmux-navigation',

  -- Cute UI
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Git integration
  'tpope/vim-fugitive',

  -- Commenting code
  'tomtom/tcomment_vim',

  -- Fuzzy finder
  {
    'nvim-lua/telescope.nvim', tag = '0.1.5',
    dependencies = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'jremmen/vim-ripgrep'},
      {'sharkdp/fd'},
    }
  },

  -- Treesitter syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

  -- LSP
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  -- https://github.com/williamboman/mason.nvim
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/vim-vsnip'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  },

  'simrat39/rust-tools.nvim',

}


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
