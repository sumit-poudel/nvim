# nvim

A personal Neovim configuration written in Lua, built around a modern, minimal plugin setup with `vim.pack` and a curated set of productivity-focused plugins.

## Overview

This config includes:

- Lua-based Neovim setup
- Keymaps and custom commands
- LSP configuration
- Tree-sitter support
- Formatting and linting
- Telescope-based search and navigation
- Mini.nvim plugins for statusline, files, completion, snippets, and more
- Terminal integration with `toggleterm`
- Git workflow support via `vim-fugitive`

## Structure

```text
.
├── init.lua
├── lua/
│   ├── commands.lua
│   ├── keymaps.lua
│   ├── lsp.lua
│   ├── matugen.lua
│   ├── options.lua
│   ├── pack.lua
│   └── treesitter.lua
├── nvim-pack-lock.json
└── README.md
```

## Requirements

- Neovim 0.10+ recommended
- Git
- Optional: tmux for the bundled terminal workflow

## Installation

Clone this repository into your Neovim config directory:

```bash
git clone https://github.com/sumit-poudel/nvim ~/.config/nvim
```

Then launch Neovim:

```bash
nvim
```

The configuration will load its Lua modules automatically. If any plugins are missing, they will be resolved by the `vim.pack` setup when Neovim starts.

## Key features

- `mini.files` and `Aerial` for navigation and outlines
- `telescope.nvim` for fuzzy find and grep
- `conform.nvim` + `nvim-lint` for formatting and linting
- `nvim-lspconfig` with language server setup
- `mini.completion`, `mini.snippets`, and `mini.ai` for editing ergonomics
- `multiple-cursors.nvim` for multi-cursor editing
- `vim-fugitive` + `mini.diff` for Git workflows

## Customization

You can tweak behavior by editing files under `lua/`:

- `lua/options.lua` for editor behavior and UI options
- `lua/keymaps.lua` for keyboard shortcuts
- `lua/lsp.lua` for LSP configuration
- `lua/pack.lua` for plugin setup and plugin-specific mappings

## License

This project is provided as-is for personal use.
