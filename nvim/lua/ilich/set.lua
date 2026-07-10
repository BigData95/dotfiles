-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.tabstop = 4        -- How many spaces a tab looks like
vim.opt.softtabstop = 4    -- How many spaces a tab feels like while editing
vim.opt.shiftwidth = 4     -- How many spaces indentation uses
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Auto-indent new lines

-- Lines
vim.opt.wrap = false      -- Do not visually wrap long lines
vim.opt.linebreak = true  -- If wrap is enabled, wrap at words
vim.opt.scrolloff = 8     -- Keep 8 lines above/below cursor while scrolling
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right when scrolling horizontally

-- Search
vim.opt.hlsearch = false  -- Do not keep search results highlighted forever
vim.opt.incsearch = true  -- Show search matches while typing
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- But respect uppercase if you type uppercase

-- Appearance
vim.opt.termguicolors = true -- Better colors
vim.opt.signcolumn = "yes"   -- Always show left column for diagnostics/git signs
vim.opt.cursorline = true    -- Highlight current line

-- Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p") -- Neovim does not create custom undo dirs itself
vim.opt.undodir = undodir

-- Splits
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Completion
vim.opt.completeopt = "menu,menuone,noinsert"
