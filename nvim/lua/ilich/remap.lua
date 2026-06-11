vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Visual Mode Block Movements
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected block down with auto-indent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected block up with auto-indent" })

-- Normal Mode Enhancements
vim.keymap.set("n", "J", "mZJ`z", { desc = "Join line below to current line without moving cursor" })

-- Centered Navigation Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half-page and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half-page and center cursor" })

-- Centered Search Matching
vim.keymap.set("n", "n", "nzzzv", { desc = "Jump to next search match and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Jump to previous search match and center cursor" })

-- Advanced Register / Clipboard Operations
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over selection without losing yanked text" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank line/motion directly to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selected text directly to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank everything from cursor to end of line to system clipboard" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete line/motion into the void register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete selected text into the void register" })

-- Escape Enhancements & Safety Nets
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Make Ctrl+C behave exactly like Escape in insert mode" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable problematic Ex mode shortcut" })

-- Project-Wide Refactoring & Scripting
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Initialize search-and-replace for word under cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable via chmod" })

-- Project Navigation (The Tmux Sessionizer)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Launch tmux-sessionizer fuzzy finder in new window" })

-- Code Cleanup (Manual LSP Formatting)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Manually trigger active LSP formatter" })

-- Global Project Error Navigation (Quickfix List)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Jump to next quickfix error and center cursor" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Jump to previous quickfix error and center cursor" })

-- Buffer-Local Error Navigation (Location List)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Jump to next location list target and center cursor" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Jump to previous location list target and center cursor" })

-- Configuration Hot-Reloading
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source (hot-reload) the active Lua layout configuration" })
