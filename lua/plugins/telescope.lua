return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-lua/plenary.nvim" },
  },
  cmd = "Telescope",
  keys = {
    -- { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<C-p>", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", desc = "Find Files" },
    { "\\", "<cmd>Telescope live_grep<CR>", desc = "Find a string" },
    -- { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
    -- { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
    -- { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers" },
    { "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Git status" },
    { "<leader>fs", "<cmd>Telescope git_stash<cr>", desc = "Git stash" }
  },
  config = function ()
    local actions = require("telescope.actions")
    require("telescope").setup {
      defaults = {
        vimgrep_arguments = { 'rg', '--hidden', '-g', '!.git', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
        mappings = {
          i = {
            ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    }
  end
}
