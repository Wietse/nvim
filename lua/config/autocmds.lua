-- Autocommand functions

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local utils = require("utils")

local augroup = vim.api.nvim_create_augroup      -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd      -- Create autocommand
local usercmd = vim.api.nvim_create_user_command -- Create user command

-- This is handled by the conform and/or lsp plugins
-- -- Remove whitespace on save
-- autocmd("BufWritePre", {
--   pattern = {
--     "c",
--     "cpp",
--     "css",
--     "html",
--     "javascript",
--     "json",
--     "lua",
--     "python",
--     "rust",
--     "scss",
--     "typescript",
--     "xhtml",
--     "xml",
--     "yaml",
--   },
--   -- command = ":%s/\\s\\+$//e"
--   command = ":let w:wv = winsaveview() | %s/\\s\\+$//e | call winrestview(w:wv)",
-- })

-- Disable colorcolumn for prose-like filetypes
augroup("setLineLength", { clear = true })
autocmd("Filetype", {
  group = "setLineLength",
  pattern = { "text", "markdown" },
  command = "setlocal cc=0 textwidth=80",
})

-- This is handled by the conform and/or lsp plugins
-- -- Set indentation to 2 spaces
-- augroup("setIndent", { clear = true })
-- autocmd("Filetype", {
--   group = "setIndent",
--   pattern = {
--     "css",
--     "html",
--     "javascript",
--     "json",
--     "lua",
--     "scss",
--     "typescript",
--     "xhtml",
--     "xml",
--     "yaml",
--   },
--   command = "setlocal shiftwidth=2 tabstop=2",
-- })

-- For TOML I need to find out the best way...
-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
  group = "setIndent",
  pattern = { "html", "lua", "toml" },
  command = "setlocal shiftwidth=2 tabstop=2",
})


function _G.preserve_cursor(cmd)
  local win_view = vim.fn.winsaveview()
  vim.cmd(cmd)
  vim.fn.winrestview(win_view)
end

-- FormatXML command
vim.api.nvim_create_user_command("FormatXML", function()
  _G.preserve_cursor(
    ':%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"'
  )
end, {
  desc = "Formats JSON buffer with jq",
})

-- FormatJSON command
vim.api.nvim_create_user_command("FormatJSON", function()
  _G.preserve_cursor(":%!jq .")
end, {
  desc = "Formats JSON buffer with jq",
})

-- Kill diagnostics as soon as a fugitive buffer opens
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "fugitive://*",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

-- If an LSP *does* attach, immediately detach pylsp + ruff for fugitive buffers
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    if not utils.is_fugitive_buf(bufnr) then return end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client.name == "pylsp" or client.name == "ruff" then
      -- Turn off diagnostics for good measure
      vim.diagnostic.enable(false, { bufnr = bufnr })
      -- Detach the client from this buffer
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, client.id)
      end)
    end
  end,
})
