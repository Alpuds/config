" Ensure files are read as what I want
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/.local/share/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
                    "\ {'path': 'another directory', 'syntax': 'markdown', 'ext': '.md'},
                    \]
let g:vimwiki_global_ext = 0
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

nnoremap <leader>v :VimwikiIndex<CR>
nnoremap <leader>vs :VimwikiUISelect<CR>
