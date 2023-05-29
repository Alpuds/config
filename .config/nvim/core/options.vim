"------------------------
" ======= Editing =======
"------------------------
let mapleader=' '
set encoding=utf-8
set mouse=a                                  " Enable mouse support
set clipboard+=unnamedplus                     " Copy/paste to system clipboard
set noswapfile                                 " Don't use swapfile
filetype plugin on

"------------------------
" ======= UI =======
"------------------------
set nohlsearch                     " Disable search highlight
set number relativenumber          " Show numbers relative to the cursor
set scrolloff=7                    " Keep the cursor 7 lines from the edge when scrolling
set splitright                     " Vertical split to the right
set splitbelow                     " Horizontal split to the bottom
set ignorecase                     " Ignore case letters when search
set smartcase                      " Ignore lowercase for the whole pattern
set linebreak                      " Wrap on word boundary
set termguicolors                  " Enable 24-bit RGB colors
set wildmode=longest,list,full     " Enable autocompletion

"------------------------
" ======= Tabs, indent =======
"------------------------
set expandtab        " Use spaces instead of tabs
set shiftwidth=4     " Shift 4 spaces when tab
set softtabstop=4
set tabstop=4        " 1 tab == 4 spaces
set smartindent      " Autoindent new lines
