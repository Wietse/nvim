-- General Neovim settings

-- Default options are not included (see :h nvim-defaults)

local C = require("config.constants")

local g = vim.g
local opt = vim.opt

opt.mouse = "a" -- Enable mouse support
opt.backup = false -- don't make a backup before writing a file
opt.swapfile = false -- don't use a swapfile for the buffer

g.python3_host_prog = vim.fn.expand("$PYENV_ROOT/versions/nvim-py3.12/bin/python")

-- User interface

opt.hidden = true -- allow hidden buffers (instead of unloading them)
opt.history = 1000 -- remember N lines in history
opt.lazyredraw = true -- don't redraw the screen when executing macros
opt.wrap = false -- display lines as one long line
opt.synmaxcol = 300 -- max column for syntax highlighting
opt.linebreak = true -- Wrap on word boundary
-- opt.termguicolors = false         -- Enable 24-bit RGB colors
opt.splitbelow = true -- vertical split below the current screen
opt.splitright = true -- horizontal splits to the right
opt.switchbuf:append("useopen") -- switch to the first window where the specified buffer is open
opt.diffopt:append("vertical") -- prefer vertical splits for diffs
opt.diffopt:append("context:25") -- show a lot of context around the changed lines
opt.diffopt:append("algorithm:patience") -- Use the specified diff algorithm with the internal diff engine
opt.diffopt:append("indent-heuristic") -- Use the indent heuristic for the internal diff library

opt.shiftwidth = 4 -- shift by 4 spaces when shifting lines with >> or <<
opt.tabstop = 4 -- number of spaces to use for a <Tab>
opt.softtabstop = 4 -- number of spaces to use for softtab
opt.expandtab = true -- always expand <Tab> to 4 spaces (don't use <Tab>)
opt.textwidth = C.txtwidth -- when appropriate, break lines after a maximum width of `textwidth`
-- opt.formatoptions:remove({ "c", "r", "o" })  -- see :h fo-table

opt.cursorline = false -- highlight the line the cursor is on
opt.number = true -- show line numbers
opt.signcolumn = "yes" -- always show the 'sign column' (e.g. to indicate errors)
opt.scrolloff = 2 -- number of lines to keep above and below the cursor when scrolling vertically
opt.sidescrolloff = 2 -- number of columns to keep right and left of the cursor when scrolling horizontally
opt.completeopt = "menu,menuone,noinsert,noselect"
opt.wildmode = "longest,full,full" -- complete the next full match
opt.wildignorecase = true -- ignore case when completing file names
opt.wildignore = ".git,*.o,*~,*.pyc,*.zip,__pycache__,*.DS_Store" -- list of filepatterns to ignore for file completion
opt.whichwrap:append("h,l,<,>") -- allow to move over linebreaks
opt.fileignorecase = true -- case insensitive file and directory names
opt.incsearch = true -- start matching the search pattern immediatly
opt.hlsearch = true -- highlight the search pattern
opt.smartcase = true -- case insensitive search except when using an uppercase char
opt.showmatch = true -- show matching pairs of brackets
opt.smartindent = true -- be smarter about autoindent
opt.colorcolumn = { C.txtwidth } -- line length marker
-- opt.listchars = "tab:»·,trail:·,nbsp:+"   -- show these chars for <Tab> and for trailing whitespace
opt.listchars = {
  tab = "»·",
  trail = "·",
  nbsp = "+",
} -- show these chars for <Tab> and for trailing whitespace
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkon100"

-- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
