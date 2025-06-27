return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "folke/neodev.nvim",
  opts = {
    servers = {
      rust_analyzer = {
        mason = false,
      },
      python_lsp_server = {
        mason = false,
      },
      pylsp = {
        mason = false,
      },
    },
    setup = {
      rust_analyzer = function()
        return true
      end,
    },
  },
  config = function()
    local lspconfig = require "lspconfig"
    local icons = require "user.icons"

    -- diagnostic config
    vim.diagnostic.config({
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = icons.diagnostics.Error },
          { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
          { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
          { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
        },
      },
      virtual_text = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    -- local diagnostic_opts = vim.lsp.diagnostic.config()
    -- if diagnostic_opts then
    --   for _, sign in ipairs(vim.tbl_get(diagnostic_opts, "signs", "values") or {}) do
    --     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    --   end
    -- end

    require("lspconfig.ui.windows").default_options.border = "rounded"

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set
      keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      keymap("n", "gl", "<cmd>lua vim.lsp.diagnostic.open_float<CR>", opts)
      keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next<CR>", opts)
      keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev<CR>", opts)
      keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action<CR>", opts)
      keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename<CR>", opts)
      keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.signature_help<CR>", opts)
      keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format<CR>", opts)
    end

    local common_capabilities = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      return capabilities
    end

    local servers = require("user.languages").servers
    table.insert(servers, "pylsp")
    table.insert(servers, "ruff")
    for _, server in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = common_capabilities(),
      }

      local require_ok, settings = pcall(require, "user.lspsettings." .. server)
      if require_ok then
        -- vim.print(settings)
        opts = vim.tbl_deep_extend("force", settings, opts)
        -- vim.print(opts)
      end

      if server == "lua_ls" then
        vim.print(settings)
        require("neodev").setup {}
      end

      -- if server == "pylsp" then
      --   vim.print(opts)
      -- end

      -- vim.print(opts)
      lspconfig[server].setup(opts)
    end
  end,
}
