## Luarocks

```
sudo apt install luarocks
```

## Debugging

Show the configuration of an LSP client attached to the buffer:

```
:lua print(vim.inspect(vim.lsp.get_active_clients()))
```
