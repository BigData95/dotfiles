# Neovim Keymaps

**Leader key = `Space`.** Tip: press `Space` (or `g`, `[`, `]`, …) and pause —
**which-key** pops up everything available from there. That is the fastest way
to learn these.

## Files & navigation

| Key | Action |
|-----|--------|
| `<leader>pv` | Open netrw file explorer |
| `<leader>pf` | Telescope: find files |
| `Ctrl-p` | Telescope: git files only |
| `<leader>pg` | Telescope: live grep (search as you type) |
| `<leader>ps` | Telescope: grep for a fixed string (prompts first) |
| `Ctrl-f` | tmux-sessionizer in a new tmux window |

## Harpoon (per-project file bookmarks)

| Key | Action |
|-----|--------|
| `<leader>a` | Add current file to harpoon list |
| `<leader>dr` | Remove current file from list |
| `Ctrl-e` | Toggle the harpoon quick menu |
| `Ctrl-h` / `Ctrl-t` / `Ctrl-n` / `Ctrl-s` | Jump to harpoon file 1 / 2 / 3 / 4 |
| `<leader>Ctrl-h` … `<leader>Ctrl-s` | Overwrite slot 1 … 4 with current file |

## LSP (active in any file with a language server)

| Key | Action |
|-----|--------|
| `gd` / `gD` | Go to definition / declaration |
| `gi` | Go to implementation |
| `gr` | List references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol project-wide |
| `<leader>ca` | Code action (imports, quick-fixes; also ruff fixes in Python) |
| `[d` / `]d` | Previous / next diagnostic (with floating detail) |
| `<leader>e` | Show diagnostic under cursor in a float |

## Diagnostics panel (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle project-wide diagnostics list |
| `<leader>xb` | Toggle diagnostics for current buffer only |
| `<leader>xq` | Toggle quickfix list in Trouble |
| `<leader>xs` | Toggle document symbols outline |

## Formatting

| Key | Action |
|-----|--------|
| `<leader>f` | Format file (or visual selection) via conform |
| *(on save)* | Auto-format: ruff (Python), prettierd (JS/TS/JSX/HTML/CSS/JSON/YAML/MD), goimports+gofumpt (Go), terraform fmt (TF), stylua (Lua) |

## Completion & snippets (insert mode)

| Key | Action |
|-----|--------|
| `Ctrl-n` / `Ctrl-p` | Next / previous completion item |
| `Tab` / `Shift-Tab` | Next/prev item, or expand & jump through snippet |
| `Ctrl-Space` | Trigger completion manually |
| `Enter` | Confirm selected item |
| `Ctrl-d` / `Ctrl-f` | Scroll completion docs down / up |

## Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Fugitive git status (stage with `s`, commit with `cc` inside) |
| `]c` / `[c` | Next / previous changed hunk |
| `<leader>hs` | Stage hunk (run again to unstage) |
| `<leader>hr` | Reset (discard) hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hb` | Blame current line (full commit info) |

## Editing power moves

| Key | Mode | Action |
|-----|------|--------|
| `J` / `K` | Visual | Move selected lines down / up (re-indents) |
| `J` | Normal | Join line below without moving cursor |
| `<leader>p` | Visual | Paste over selection without losing the yank |
| `<leader>y` / `<leader>Y` | N/V | Yank to system clipboard |
| `<leader>d` | N/V | Delete without clobbering the yank register |
| `<leader>s` | Normal | Search & replace word under cursor (pre-filled) |
| `<leader>x` | Normal | `chmod +x` current file |
| `Ctrl-d` / `Ctrl-u` | Normal | Half-page scroll, cursor stays centered |
| `n` / `N` | Normal | Next/prev search match, centered |
| `Ctrl-c` | Insert | Acts exactly like Escape |
| `gcc` / `gc` | N / V | Comment line / selection (built-in) |

## Lists & misc

| Key | Action |
|-----|--------|
| `Ctrl-k` / `Ctrl-j` | Next / previous quickfix entry |
| `<leader>k` / `<leader>j` | Next / previous location-list entry |
| `<leader>u` | Toggle Undotree (visual undo history) |
| `<leader><leader>` | Re-source current lua file (config hot-reload) |
