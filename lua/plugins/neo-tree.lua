return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x", -- latest stable branch
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- for icons
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
  },
  config = function()
    local icons = require("lua.config.icons") -- same icon setup you already use

    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,

      filesystem = {
        bind_to_cwd = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          always_show = { ".gitignore", ".env" },
        },
        use_libuv_file_watcher = true,
      },

      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = false,
          indent_marker = "│",
          last_indent_marker = "└",
          expander_collapsed = icons.ui.ChevronRight,
          expander_expanded = icons.ui.ChevronShortDown,
        },
        icon = {
          folder_closed = icons.ui.Folder,
          folder_open = icons.ui.FolderOpen,
          folder_empty = icons.ui.EmptyFolder,
          folder_empty_open = icons.ui.EmptyFolderOpen,
          default = icons.ui.Text,
          symlink = icons.ui.FileSymlink,
        },
        git_status = {
          symbols = {
            added = icons.git.FileStaged,
            deleted = icons.git.FileDeleted,
            modified = icons.git.FileUnstaged,
            renamed = icons.git.FileRenamed,
            untracked = icons.git.FileUntracked,
            ignored = icons.git.FileIgnored,
            unstaged = icons.git.FileUnstaged,
            staged = icons.git.FileStaged,
            conflict = icons.git.FileUnmerged,
          },
        },
        diagnostics = {
          symbols = {
            hint = icons.diagnostics.BoldHint,
            info = icons.diagnostics.BoldInformation,
            warn = icons.diagnostics.BoldWarning,
            error = icons.diagnostics.BoldError,
          },
        },
      },

      window = {
        width = 30,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["<C-x>"] = "open_split",
          ["<C-v>"] = "open_vsplit",
          ["<C-r>"] = "refresh",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
        },
      },

      buffers = {
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = false,
      },

      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function() vim.opt_local.signcolumn = "yes" end,
        },
      },
    })
  end,
}
