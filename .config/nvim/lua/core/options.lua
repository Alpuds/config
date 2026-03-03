--------------------------
-- ======= Editing =======
--------------------------
vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"                  -- enable mouse clicks
vim.opt.clipboard = "unnamedplus"    -- Copy/Paste system clipboard
vim.opt.swapfile = false             -- Don't use swapfile

--------------------------
-- ======= UI =======
--------------------------
vim.opt.hlsearch = false               -- Disable search highlight
vim.opt.number = true
vim.opt.relativenumber = true          -- Show numbers relative to the cursor
vim.opt.scrolloff = 7                  -- Keep the cursor 7 lines from the edge when scrolling
vim.opt.splitright = true              -- Vertical split to the right
vim.opt.splitbelow = true              -- Horizontal split to the bottom
vim.opt.ignorecase = true              -- Ignore case letters when serach
vim.opt.smartcase = true               -- Ignore lowercase for the whole pattern
vim.opt.linebreak = true               -- Wrap on word boundary
vim.opt.termguicolors = true           -- Enable 24-bit RGB colors
vim.opt.wildmode = "longest,list,full" -- Enable autocompletion

--------------------------
-- ==== Tabs, indent =====
--------------------------
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.shiftwidth = 4      -- Shift 4 space when tab
vim.opt.softtabstop = 4
vim.opt.tabstop = 4         -- 1 tab == 4 spaces
vim.opt.smartindent = true  -- Autoindent new lines
