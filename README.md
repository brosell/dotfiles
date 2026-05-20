# dotfiles

Personal development environment configuration for Neovim and Tmux.

## Overview

This repository contains a modern, feature-rich development setup with:
- **Neovim** - Configured with lazy.nvim, LSP, Treesitter, and 30+ plugins
- **Tmux** - Dracula theme, vim integration, and sensible defaults

---

## Neovim Configuration

### Plugin Manager

Uses **lazy.nvim** which auto-installs on first launch. All plugins are lazy-loaded for fast startup.

### Plugins by Category

#### UI & Appearance
| Plugin     | Description                            |
|--------    |-------------                           |
| catppuccin | Colorscheme (frappe variant)           |
| alpha-nvim | Dashboard with ASCII art               |
| lualine    | Statusline with git, diagnostics, tabs |
| neo-tree   | File explorer with hover previews      |
| focus.nvim | Auto-resize windows on focus           |
| tint.nvim  | Dims unfocused windows                 |

#### Fuzzy Finding & Navigation
| Plugin | Description |
|--------|-------------|
| telescope.nvim | Fuzzy finder with file-first path display |
| telescope-live-grep-args | Grep with ripgrep arguments |
| vim-tmux-navigator | Seamless vim/tmux pane navigation |

#### LSP & Completion
| Plugin | Description |
|--------|-------------|
| nvim-lspconfig | LSP for TypeScript, Ruby, HTML, Lua |
| mason.nvim | LSP/DAP/Linter installer (auto-install) |
| nvim-cmp | Completion engine with snippets |
| none-ls | Formatters: stylua, prettier, rubocop |
| glance.nvim | Peek definitions/references in popup |

#### Git
| Plugin | Description |
|--------|-------------|
| vim-fugitive | Git commands |
| gitsigns.nvim | Signs, hunk preview, inline blame |
| codediff.nvim | VSCode-style diff viewer |

#### Editing
| Plugin | Description |
|--------|-------------|
| Comment.nvim | Toggle comments (gcc, gc) |
| vim-surround | Surround text objects |
| vim-sleuth | Auto-detect indentation |
| boole.nvim | Toggle booleans with Ctrl+a/x |
| mini.move | Move lines with Alt+hjkl |

#### Productivity
| Plugin | Description |
|--------|-------------|
| vim-dadbod-ui | Database client (SQL, MySQL, Postgres) |
| kulala.nvim | HTTP client for .http files |
| tome | Playbook runner (execute shell scripts) |
| opencode.nvim | AI coding assistant |

---

### Key Bindings

**Leader key:** `<Space>`

#### Navigation
| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate windows (works across tmux) |
| `Ctrl+p` | Find files |
| `<leader>lg` | Live grep |
| `<leader><leader>` | Recent files |
| `<leader>fb` | List buffers |
| `<leader>fs` | Document symbols |

#### File Explorer
| Key | Action |
|-----|--------|
| `Ctrl+n` | Toggle file tree |
| `<leader>bf` | Buffers in floating window |
| `K` | Show file path (in tree) |

#### LSP
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find references |
| `<leader>ca` | Code actions |
| `<leader>r` | Rename symbol |
| `]g` / `[g` | Next/prev diagnostic |
| `<leader>f` | Format buffer |

#### LSP Peek (Glance)
| Key | Action |
|-----|--------|
| `<leader>gD` | Peek definitions |
| `<leader>gR` | Peek references |
| `<leader>gY` | Peek type definitions |
| `<leader>gM` | Peek implementations |

#### Git
| Key | Action |
|-----|--------|
| `<leader>gp` | Preview hunk |
| `<leader>gt` | Toggle inline blame |

#### Editing
| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gc` (visual) | Comment selection |
| `Alt+h/j/k/l` | Move line/selection |
| `Ctrl+a/x` | Increment/toggle values |

#### Windows
| Key          | Action             |
|-----         |--------            |
| `<leader>wf` | Toggle auto-resize |
| `<leader>we` | Equalize windows   |
| `<leader>wm` | Maximize window    |

#### Floating Terminal
| Key         | Action                   |
|-----        |--------                  |
| `<leader>t` | Toggle floating terminal |
| `Esc Esc`   | Close terminal           |

#### HTTP Client (kulala)
| Key | Action |
|-----|--------|
| `<leader>Rs` | Send HTTP request |
| `<leader>Ra` | Send all requests |
| `<leader>Rb` | Open scratchpad |

#### AI Assistant (opencode)
| Key | Action |
|-----|--------|
| `<leader>oa` | Ask opencode |
| `<leader>oe` | Execute action |
| `<leader>op` | Add to context |
| `<leader>ot` | Toggle opencode |

#### Special Commands
| Command | Description |
|---------|-------------|
| `:Tabname <name>` | Name current tab |
| `:DiffO` | Diff against merge-base with main |
| `:DBUI` | Open database UI |

- mariadb://[user[:password]@][host][:port]/[database]
  - !! database not required

#### Value Toggling (boole.nvim)
Ctrl+a/x cycles through custom values:
- `public` → `private` → `protected`
- `describe` → `fdescribe` → `xdescribe`
- `it` → `xit` → `fit`
- `let` ↔ `const`

---

### Notable Features

- **File-first Telescope** - Shows filename before path for easier scanning
- **Dimmed unfocused windows** - Tint + Focus provide visual clarity
- **Sticky context header** - Shows current function/class at top of buffer
- **Tab naming** - Custom tabs with `:Tabname` displayed in tabline
- **Auto file reload** - Files refresh when changed externally
- **Built-in HTTP client** - Test APIs directly from `.http` files

---

## Tmux Configuration

### Plugin Manager

Uses **TPM** (Tmux Plugin Manager) which auto-installs on first launch.

### Plugins
| Plugin | Description |
|--------|-------------|
| vim-tmux-navigator | Seamless vim/tmux pane navigation |
| tmux-sensible | Sensible defaults |
| dracula/tmux | Theme with powerline |
| tome | Playbook runner |

### Key Bindings

| Key | Action |
|-----|--------|
| `"` | Split vertically (keeps path) |
| `%` | Split horizontally (keeps path) |
| `c` | New window (keeps path) |
| `Ctrl+h/j/k/l` | Navigate panes (vim-aware) |
| `Ctrl+p` | Previous window |
| `Ctrl+n` | Next window |
| `R` | Reload config |

### Settings
- **Status bar:** Top position
- **Indexing:** Windows/panes start at 1
- **Escape delay:** 0ms (no lag)
- **History:** 50,000 lines
- **Path preservation:** New splits retain working directory

---

## Setup

### Prerequisites

#### Required
```bash
# System tools
apt install git xclip bsdmainutils

# Node.js formatter
npm install -g prettier

# Ruby tools
gem install rubocop erb_lint

# Lua formatter (choose one)
cargo install stylua
# OR install via :Mason in nvim
```

#### Recommended
- **Nerd Font** - Required for icons (neo-tree, lualine, alpha)
- **ripgrep** - Enhanced searching

### Installation

```bash
# Clone repository
git clone <repo-url> ~/dotfiles

# Symlink neovim config
ln -s ~/dotfiles/nvim ~/.config/nvim

# Symlink tmux config
ln -s ~/dotfiles/tmux ~/.config/tmux
```

### First Launch

#### Neovim
1. Launch `nvim` - lazy.nvim will auto-install
2. Plugins will download and install automatically
3. LSP servers auto-install via Mason on first file open
4. Treesitter parsers install automatically

#### Tmux
1. Launch `tmux` - TPM will auto-install
2. Press `prefix + I` to install plugins (if needed)
3. Press `prefix + R` to reload config

### LSP Servers (auto-installed)
| Server | Language |
|--------|----------|
| ts_ls | TypeScript/JavaScript |
| solargraph | Ruby |
| html | HTML |
| lua_ls | Lua |

---

## File Structure

```
nvim/
├── init.lua              # Entry point, lazy.nvim setup
├── lua/
│   ├── options.lua       # Core vim options
│   ├── keymaps.lua       # Global keymaps
│   ├── autocmds.lua      # Autocommands
│   ├── terminal.lua      # Floating terminal
│   └── plugins/          # Plugin configurations
│       ├── lsp-config.lua
│       ├── telescope.lua
│       ├── neo-tree.lua
│       └── ...

tmux/
└── tmux.conf             # Tmux configuration
```

---

## Vim-Tmux Integration

Both configs share `vim-tmux-navigator` enabling seamless navigation:
- `Ctrl+h/j/k/l` moves between vim splits and tmux panes
- No need to use tmux prefix when moving between panes
- Works in both normal mode and from terminal buffers

The `tome` plugin is also shared, allowing you to run playbook commands from either environment.
