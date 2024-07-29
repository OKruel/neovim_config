local opt = vim.opt -- for conciseness

-- swap files
opt.swapfile = true

-- line numbers
opt.relativenumber = true
opt.number = true

-- tab and indentation
opt.tabstop = 1
opt.shiftwidth = 1
opt.expandtab = true
opt.autoindent = true

-- Folding method
-- opt.foldmethod = "indent"
opt.foldlevel = 0
opt.foldminlines = 1

-- line wraping
opt.wrap = true

--search setting
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.guifont = "Symbols-2048-em Nerd Font Complete.ttf"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
-- Makes vim yank to the system clipboard
opt.clipboard = "unnamedplus"

-- split window
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- Undo tree
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
