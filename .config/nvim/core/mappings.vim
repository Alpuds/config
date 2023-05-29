"------------------------
" ======= Editing =======
"------------------------
" Control s to save
nnoremap <C-s> :w<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Map ctrl-o to delete the previous word in insert mode.
imap <C-o> <C-w>

" Perform dot commands over visual blocks
vnoremap . :normal .<CR>

" Replace ex mode with gq
map Q gq

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"------------------------
" ======= Navigation =======
"------------------------
" File tab navigation
nnoremap <tab> :tabn<CR>
nnoremap <S-tab> :tabp<CR>

" Split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Spell-check set to <leader>o, 'o' for 'orthography'
map <leader>o :setlocal spell! spelllang=en_us<CR>

"------------------------
" ======= Miscellaneous =======
"------------------------
" Check file in shellcheck
map <leader>s :!clear && shellcheck %<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>
