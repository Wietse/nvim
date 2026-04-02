return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false, -- This plugin is already lazy (filetype plugin)
    init = function()
      local utils = require("utils")

      ---@type rustaceanvim.Opts
      vim.g.rustaceanvim = {
        tools = {
          executor = require("rustaceanvim.executors").termopen,
          test_executor = require("rustaceanvim.executors").termopen,
        },

        server = {
          on_attach = function(client, bufnr)
            -- Reuse shared on_attach (Telescope definitions, diagnostics, etc.)
            utils.on_attach(client, bufnr)

            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, {
                buffer = bufnr,
                silent = true,
                noremap = true,
                desc = desc,
              })
            end

            -- Rust-specific keymaps via RustLsp
            map("n", "<leader>re", "<cmd>RustLsp explainError<CR>", "Explain error")
            map("n", "<leader>rd", "<cmd>RustLsp renderDiagnostic<CR>", "Render diagnostic")
            map("n", "<leader>rm", "<cmd>RustLsp expandMacro<CR>", "Expand macro")
            map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", "Open Cargo.toml")
            map("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", "Parent module")
            map("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", "Runnables")
            map("n", "<leader>rt", "<cmd>RustLsp testables<CR>", "Testables")
            map("n", "<leader>rD", "<cmd>RustLsp debuggables<CR>", "Debuggables")
            map("n", "<leader>rj", "<cmd>RustLsp joinLines<CR>", "Join lines")
            map("n", "<leader>ro", "<cmd>RustLsp openDocs<CR>", "Open docs.rs")
            map("n", "J", "<cmd>RustLsp joinLines<CR>", "Join lines (Rust)")
          end,

          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                command = "clippy",
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                chainingHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        },

        dap = {},
      }
    end,
  },

  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    config = function()
      local crates = require("crates")
      crates.setup({
        completion = {
          cmp = { enabled = true },
        },
      })

      -- Keymaps only active in Cargo.toml
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CratesKeymaps", { clear = true }),
        pattern = "Cargo.toml",
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end
          map("<leader>ct", crates.toggle, "Toggle crate info")
          map("<leader>cv", crates.show_versions_popup, "Show versions")
          map("<leader>cf", crates.show_features_popup, "Show features")
          map("<leader>cd", crates.show_dependencies_popup, "Show dependencies")
          map("<leader>cu", crates.update_crate, "Update crate")
          map("<leader>cU", crates.update_all_crates, "Update all crates")
        end,
      })
    end,
  },
}
