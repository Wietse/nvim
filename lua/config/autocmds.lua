-- Autocommand functions

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
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

-- FormatXML command
usercmd(
  "FormatXML",
  ':%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"',
  {}
)

-- FormatJSON command
usercmd("FormatJSON", ":%!python3 -m json.tool", {})
