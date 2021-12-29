noremap <silent> <leader>t :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
function! FernInit() abort
	nmap <buffer><expr>
		\ <Plug>(fern-my-open-expand-collapse)
		\ fern#smart#leaf(
		\	"\<Plug>(fern-action-open:selecet)",
		\	"\<Plug>(fern-action-expand)",
		\	"\<Plug>(fern-action-collapse)",
		\)
	nmap <buffer> o <Plug>(fern-my-open-expand-collapse)
	nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
	nmap <buffer> n <Plug>(fern-action-new-path)
	nmap <buffer> d <Plug>(fern-action-remove)
	nmap <buffer> m <Plug>(fern-action-move)
	nmap <buffer> M <Plug>(fern-action-rename)
	nmap <buffer> h <Plug>(fern-action-hidden-toggle)
	nmap <buffer> r <Plug>(fern-action-reload)
	nmap <buffer> s <Plug>(fern-action-mark:toggle)
	nmap <buffer> S <Plug>(fern-action-mark:clear)
	nmap <buffer> b <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
	nmap <buffer><nowait> < <Plug>(fern-action-leave)
	nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
	autocmd!
	autocmd FileType fern call FernInit()
augroup END

" Fern: presentation
let g:fern#renderer#default#collapsed_symbol = "▷ "
let g:fern#renderer#default#expanded_symbol  = "▼ "
let g:fern#renderer#default#root_symbol      = '~ '
