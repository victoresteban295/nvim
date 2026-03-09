# Neovim Configuration

Personal Neovim setup built on [lazy.nvim](https://github.com/folke/lazy.nvim) with LSP support, fuzzy finding, and syntax highlighting for Python, Java, JavaScript, HTML, and CSS.

## Requirements

- Neovim >= 0.10
- [Node.js](https://nodejs.org/) (for JS/TS/HTML/CSS LSP servers)
- [Java 17+](https://adoptium.net/) (for jdtls)
- [Python 3](https://www.python.org/) (for pyright, black, isort)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

## Installation

```bash
git clone https://github.com/victoresteban295/nvim ~/.config/nvim
nvim
```

On first launch, lazy.nvim will automatically install all plugins. LSP servers are managed by Mason — run `:MasonInstall` or let `mason-lspconfig` handle it on startup.

## Structure

```
~/.config/nvim/
├── init.lua                   # Entry point
└── lua/user/
    ├── core/
    │   ├── options.lua        # Editor settings
    │   └── keymaps.lua        # Global keymaps
    ├── lazy.lua               # Plugin manager bootstrap
    └── plugins/
        ├── nvim-cmp.lua       # Autocompletion
        ├── telescope.lua      # Fuzzy finder
        ├── treesitter.lua     # Syntax highlighting
        ├── formatting.lua     # Formatting via conform.nvim
        ├── nvim-tree.lua      # File explorer
        ├── lualine.lua        # Status line
        └── lsp/
            ├── lsp-config.lua # LSP server setup
            ├── linting.lua    # Linting via none-ls
            └── java.lua       # Java LSP (nvim-jdtls)
```

## LSP Servers

| Language | Server |
|---|---|
| Python | pyright |
| JavaScript / TypeScript | vtsls |
| Java | jdtls (nvim-jdtls) |
| HTML | vscode-html-language-server |
| CSS | vscode-css-language-server |
| JSON | vscode-json-language-server |
| Lua | lua-language-server |

## Keymaps

Leader key: `Space`

### Navigation
| Key | Action |
|---|---|
| `<leader>e` | Toggle file tree |
| `<C-h/j/k/l>` | Navigate splits |
| `<S-h>` / `<S-l>` | Previous / next buffer |

### Fuzzy Finding (Telescope)
| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find word under cursor |
| `<leader>ft` | Find TODOs |

### LSP
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gR` | Show references |
| `gi` | Show implementations |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Line diagnostics |
| `<leader>D` | Buffer diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart LSP |

### Formatting
| Key | Action |
|---|---|
| `<leader>mp` | Format file or selection |

### Java (jdtls extras)
| Key | Action |
|---|---|
| `<leader>jo` | Organize imports |
| `<leader>jv` | Extract variable |
| `<leader>jc` | Extract constant |
| `<leader>jm` | Extract method |
