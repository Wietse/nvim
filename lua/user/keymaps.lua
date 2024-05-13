-- Define keymaps of Neovim and installed plugins.

local map = require('utils').map


vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- set a python breakpoint
-- nmap <leader>b Oimport pudb; pudb.set_trace()  # BREAKPOINT<esc>^
map('n', '<leader>b', 'Oimport pudb; pudb.set_trace()  # BREAKPOINT<esc>')

-- Close window
map('n', '<leader>q', ':q<cr>')

-- Write buffer
map('n', '<leader>w', ':w!<cr>')

-- Close all windows and exit from Neovim
map('n', '<leader>Q', ':qa!<CR>')

-- make Y behave like C or D
map('n', 'Y', 'y$')

-- when searching center the search result in center of screen
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- insert a linebreak
map('n', '<leader>l', 'i<cr><esc>')

-- treat long lines as break lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Don't overwrite the registry on "paste" (make it possible to apply a change multiple
-- times from the same registry).
map('v', 'p', 'P')

-- Change split orientation
map('n', '<leader>sk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>sh', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')


local function map_next_family(target, cmd_family)
  map('n', ']' .. target, ':' .. cmd_family .. 'next<cr>')
  map('n', '[' .. target, ':' .. cmd_family .. 'previous<cr>')
  map('n', ']' .. string.upper(target), ':' .. cmd_family .. 'last<cr>')
  map('n', '[' .. string.upper(target), ':' .. cmd_family .. 'first<cr>')
end

map_next_family('b', 'b')   -- move between buffers
map_next_family('l', 'l')   -- move between entries in local list
map_next_family('q', 'c')   -- move between entries in quickfix list
map_next_family('t', 't')   -- move between entries in tag stack
