let mapleader = ' '

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" tpope plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" General plugins for coding
Plug 'neovim/nvim-lspconfig'
Plug 'filipdutescu/renamer.nvim'
Plug 'nvim-lua/plenary.nvim'

" Telescope:
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*'}
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/fern.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Plugin for Auto-completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'

" Plugin for LaTeX
"Plug 'lervag/vimtex'

" Visual enhancements
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'kovetskiy/sxhkd-vim'

" Plugins for prose
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

call plug#end()

" Source configs for plugins
" Theme
source ~/.config/nvim/themes/gruvbox.vim

" Auto-completion:
source ~/.config/nvim/tools/nvim_cmp.lua

" Tree-Sitter
source ~/.config/nvim/tools/tree_sitter.vim

" LSP
source ~/.config/nvim/tools/lsp/python-lsp.lua
source ~/.config/nvim/tools/lsp/lsp_config.vim
source ~/.config/nvim/tools/lsp/texlab-lsp.lua

" Renamer
source ~/.config/nvim/tools/renamer.lua

" Telescope
source ~/.config/nvim/tools/telescope.lua

" Fern (tree viewer)
source ~/.config/nvim/tools/fern.vim

" LuaSnips
source ~/.config/nvim/tools/luasnip.lua

" Notes/prose:
source ~/.config/nvim/tools/vimwiki.vim

" VimTeX
"source ~/.config/nvim/tools/vimtex.vim

" Mappings for plugins
" Map leader y to activate Goyo. Goyo plugin makes text more readable when writing prose
map <leader>y :Goyo \| set bg=dark \| set linebreak<CR>

" Preview the markdown file in a browser tab
map <leader>m :MarkdownPreview

" Leader g to :G for an overview of the working tree from vim-fugitive
nnoremap <leader>g :G<CR>

" Some basics:
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set termguicolors
filetype plugin on
syntax on
set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set ignorecase
set smartcase
set scrolloff=7
set noswapfile
set hidden
set conceallevel=0
set wrap
set linebreak
" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks
vnoremap . :normal .<CR>

" Control s to save
nnoremap <C-s> :w<CR>

" Better tabbing:
vnoremap < <gv
vnoremap > >gv

" Map ctrl-o to delete the previous word in insert mode.
imap <C-o> <C-w>

" Spell-check set to <leader>o, 'o' for 'orthography'
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" File tab navigation:
nnoremap <tab> :tabn<CR>
nnoremap <S-tab> :tabp<CR>

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace ex mode with gq
map Q gq

" Check file in shellcheck
map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing:
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

" Recompile dwmblocks on config edit.
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
