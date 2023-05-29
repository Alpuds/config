" Enable VimTeX to use deoplete for auto-completion
"call deoplete#custom#var('omni', 'input_patterns', {
"      \ 'tex': g:vimtex#re#deoplete
"      \})

" Compile
map <leader>c :VimtexCompile<CR>

" Use Zathura for PDF viewing
let g:vimtex_view_method = 'zathura'
