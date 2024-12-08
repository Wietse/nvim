return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "folke/neodev.nvim",
  opts = {
    servers = {
      rust_analyzer = {},
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

    local diagnostic_opts = vim.diagnostic.config()
    if diagnostic_opts then
      for _, sign in ipairs(vim.tbl_get(diagnostic_opts, "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set
      keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "gl", vim.diagnostic.open_float, opts)
      keymap("n", "]d", vim.diagnostic.goto_next, opts)
      keymap("n", "[d", vim.diagnostic.goto_prev, opts)
      keymap("n", "<leader>a", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>r", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>s", vim.lsp.buf.signature_help, opts)
      keymap("n", "<leader>f", vim.lsp.buf.format, opts)
    end

    local common_capabilities = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      return capabilities
    end

    local servers = require("user.languages").servers
    table.insert(servers, "pylsp")
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
