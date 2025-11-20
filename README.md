# Neovim Configuration

A modern, performant Neovim configuration built with Lua, featuring LSP support,
tree-sitter syntax highlighting, and a curated set of plugins for an enhanced
editing experience.

## Requirements

- Neovim >= 0.11.4
- Git
- A Nerd Font (for icons)
- Python 3 (for Python features and debugging)
- Node.js and npm (for LSP servers)
- Rust and cargo (for Rust development)
- Go (for docker-language-server)

## Features

- 🚀 **Fast startup** with lazy loading and bytecode caching
- 🔧 **LSP support** for multiple languages
- 🎨 **Tree-sitter** syntax highlighting
- 📁 **Neo-tree** file explorer
- 🔍 **Telescope** fuzzy finder
- 🐛 **DAP** debugging support (Python)
- ✨ **Auto-completion** with nvim-cmp
- 🎯 **Git integration** with fugitive and gitsigns
- 💅 **Code formatting** with conform.nvim

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
```bash
rustup component add rust-analyzer
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

# Rust (comes with rustup)
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

### LSP
- `gd` - Go to definition
- `gD` - Go to type definition
- `gr` - Show references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>a` - Code actions
- `<leader>ff` - Format buffer/selection
- `]d` / `[d` - Next/previous diagnostic

### Git
- `<leader>gb` - Git blame
- `<leader>gd` - Git diff (3-way)
- `<leader>gB` - Open in GitHub

### Debugging (Python)
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
- `lsp/*.lua` - Individual server configs
- `lua/config/lsp.lua` - List of enabled servers

## Structure

```
.
├── init.lua                    # Entry point
├── lsp/                        # LSP server configurations
├── lua/
│   ├── bootstrap-lazy.lua      # Lazy.nvim setup
│   ├── config/
│   │   ├── autocmds.lua        # Autocommands
│   │   ├── constants.lua       # Constants
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
:checkhealth
```

### Python features not working
Ensure `NVIM_PYTHON_HOST` environment variable is set and points to a valid Python installation with pynvim installed.

### Plugins not loading
Try removing the lazy-lock.json and restarting:
```bash
rm ~/.local/share/nvim/lazy-lock.json
```

## License

MIT License - See LICENSE file for details
