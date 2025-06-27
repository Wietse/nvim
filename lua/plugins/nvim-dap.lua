return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_python = require("dap-python")
    local map = require('utils').map

    map('n', '<leader>b', ':DapToggleBreakpoint<CR>')
    map('n', '<F5>', ':DapStepInto<CR>')
    map('n', '<F6>', ':DapStepOver<CR>')
    map('n', '<F7>', ':DapStepOut<CR>')
    map('n', '<leader>dc', ':DapContinue<CR>')
    map('n', '<leader>dq', ':DapTerminate<CR>')
    map('n', '<leader>dt', ':lua require("dap").run_to_cursor()<CR>')

    dapui.setup()
    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    -- Toggle DAP UI
    map("n", "<leader>du", ":lua require('dapui').toggle()<CR>")

    require("nvim-dap-virtual-text").setup({
      commented = true, -- Show virtual text alongside comment
    })

    dap_python.setup("uv")
    map('n', '<leader>dm', ":lua require('dap-python').test_method()<CR>")
    map('n', '<leader>df', ":lua require('dap-python').test_class()<CR>")

    vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

  end
}
