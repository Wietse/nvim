# Neovim Configuration

A modern, performant Neovim configuration built with Lua, featuring LSP support,
tree-sitter syntax highlighting, and a curated set of plugins for an enhanced
editing experience.

## Requirements

- Neovim >= 0.12.0
- Git
- A Nerd Font (for icons)
- Python 3 (for Python features and debugging)
- Node.js and npm (for LSP servers)
- Rust and cargo (for Rust development)
- Go (for docker-language-server)

## Features

- **Fast startup** with lazy loading and bytecode caching
- **LSP support** for multiple languages
- **Tree-sitter** syntax highlighting and indentation for all supported filetypes
- **Neo-tree** file explorer
- **Telescope** fuzzy finder
- **DAP** debugging support (Python, Rust via codelldb)
- **Auto-completion** with nvim-cmp
- **Git integration** with fugitive and gitsigns
- **Code formatting** with conform.nvim
- **Rust tooling** with rustaceanvim and crates.nvim
- **Treesitter textobjects** and **vim-matchup** for structural editing

## Installation

1. **Backup your existing configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**
   ```bash
   git clone git@github.com:Wietse/nvim.git ~/.config/nvim
   ```

3. **Set up Python environment:**
   ```bash
   # Install Python virtual environment for Neovim
   pyenv virtualenv 3.12 nvim-py3.12
   pyenv activate nvim-py3.12
   pip install pynvim debugpy
   
   # Set environment variable in your shell rc file (.zshrc, .bashrc, etc.)
   export NVIM_PYTHON_HOST="$PYENV_ROOT/versions/nvim-py3.12/bin/python"
   ```

4. **Launch Neovim:**
   ```bash
   nvim
   ```
   
   Lazy.nvim will automatically install all plugins on first launch.
   Missing tree-sitter parsers are installed automatically on startup.

## LSP Servers

Install the LSP servers you need for your development workflow:

### Bash
```bash
npm i -g bash-language-server
```

### Docker
```bash
go install github.com/docker/docker-language-server/cmd/docker-language-server@latest
```

### HTML/CSS
```bash
npm i -g vscode-langservers-extracted
```

### JSON
```bash
npm install -g vscode-json-languageserver
```

### Lua
Download from [lua-language-server releases](https://github.com/LuaLS/lua-language-server/releases) and extract to `~/software/lua-language-server-3.15.0-linux-x64/`

### Markdown
```bash
sudo snap install marksman
```

### Python
```bash
# Install in nvim-py3.12 environment
pip install python-lsp-server python-lsp-mypy ruff sqruff
```

### Rust
Rust LSP is handled by **rustaceanvim** (which manages rust-analyzer automatically).
```bash
rustup component add rust-analyzer
```

For debugging support, install codelldb:
```bash
cd ~/software
curl -L -o codelldb.vsix https://github.com/vadimcn/codelldb/releases/download/v1.12.1/codelldb-linux-x64.vsix
unzip codelldb.vsix -d codelldb
ln -s ~/software/codelldb/extension/adapter/codelldb ~/.local/bin/codelldb
```

### TypeScript/JavaScript
```bash
npm install -g @vtsls/language-server
```

### YAML
```bash
npm install -g yaml-language-server
```

## Formatters

Install formatters as needed:

```bash
# Bash/Shell
apt install shfmt  # or your package manager

# HTML/CSS/YAML
npm install -g @fsouza/prettierd

# Lua
cargo install stylua

# Python (already installed with ruff above)

# Rust (comes with rustfmt, invoked by rust-analyzer)
```

## Project-Local Configuration

You can customize settings per project by creating a `.nvim.lua` file in your project root:

```lua
-- .nvim.lua
return {
  yaml_schemas = {
    ["./path/to/schema.json"] = "*.custom.{yml,yaml}",
  }
}
```

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Close window
- `<leader>Q` - Quit all

### File Navigation
- `<C-p>` - Find files (Telescope)
- `\` - Live grep (Telescope)
- `<leader>e` - Toggle file explorer (Neo-tree)
- `<leader>fb` - List buffers
- `<leader>fg` - Git status
- `<leader>fk` - Find keymaps

### LSP (Neovim 0.12 defaults + custom)
- `gd` - Go to definition (Telescope)
- `grr` - Show references
- `gri` - Go to implementation
- `grt` - Go to type definition
- `grn` - Rename symbol
- `gra` - Code actions
- `K` - Hover documentation
- `gF` - Format buffer
- `<leader>ff` - Format buffer/selection (conform.nvim)
- `gl` - Show diagnostics at cursor
- `]d` / `[d` - Next/previous diagnostic

### Rust (`<leader>r` prefix)
- `<leader>rr` - Runnables
- `<leader>rt` - Testables
- `<leader>rD` - Debuggables
- `<leader>re` - Explain error
- `<leader>rd` - Render diagnostic
- `<leader>rm` - Expand macro
- `<leader>rc` - Open Cargo.toml
- `<leader>rp` - Parent module
- `<leader>ro` - Open docs.rs
- `<leader>rj` / `J` - Join lines

### Cargo.toml (`<leader>c` prefix)
- `<leader>ct` - Toggle crate info
- `<leader>cv` - Show versions
- `<leader>cf` - Show features
- `<leader>cd` - Show dependencies
- `<leader>cu` - Update crate
- `<leader>cU` - Update all crates

### Git
- `<leader>gb` - Git blame
- `<leader>gd` - Git diff (3-way)
- `<leader>gB` - Open in GitHub

### Debugging
- `<leader>b` - Toggle breakpoint
- `<F5>` - Step into
- `<F6>` - Step over
- `<F7>` - Step out
- `<leader>dc` - Continue
- `<leader>dq` - Terminate
- `<leader>du` - Toggle DAP UI

## Customization

### Color Scheme
The default theme is Gruvbox (hard contrast). To change:
- Edit `lua/plugins/colorscheme.lua`

### Options
Adjust editor settings in:
- `lua/config/options.lua`

### Key Mappings
Add or modify keybindings in:
- `lua/config/keymaps.lua`

### LSP Configuration
Add or modify language servers in:
- `lsp/*.lua` - Individual server configs (auto-discovered)
- `lua/config/lsp.lua` - Diagnostic settings and LSP initialization

## Structure

```
.
├── init.lua                    # Entry point
├── after/ftplugin/             # Filetype-specific overrides
├── lsp/                        # LSP server configurations (auto-discovered)
├── queries/lua/                # Treesitter query overrides
├── lua/
│   ├── bootstrap-lazy.lua      # Lazy.nvim setup
│   ├── config/
│   │   ├── autocmds.lua        # Autocommands
│   │   ├── constants.lua       # Constants (parsers list, etc.)
│   │   ├── icons.lua           # Icon definitions
│   │   ├── keymaps.lua         # Key mappings
│   │   ├── lsp.lua             # LSP initialization
│   │   └── options.lua         # Editor options
│   ├── plugins/                # Plugin specifications
│   └── utils.lua               # Utility functions
└── .stylua.toml                # Lua formatter config
```

## Troubleshooting

### LSP not starting
Check that the binary is installed and in your PATH:
```vim
:checkhealth vim.lsp
```

### Python features not working
Ensure `NVIM_PYTHON_HOST` environment variable is set and points to a valid Python installation with pynvim installed.

### Tree-sitter errors
If you see query errors after upgrading Neovim, run `:TSUpdate` to recompile parsers. The `queries/lua/highlights.scm` file patches a known Neovim 0.12.0 bug — remove it once a fixed release is available.

### Plugins not loading
Try removing the lazy-lock.json and restarting:
```bash
rm ~/.config/nvim/lazy-lock.json
```

## License

MIT License - See LICENSE file for details
