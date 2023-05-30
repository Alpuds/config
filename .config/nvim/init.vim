" Install plugins
source ~/.config/nvim/plugins.vim

" Theme
source ~/.config/nvim/themes/gruvbox.vim

" Core configuration
source ~/.config/nvim/core/options.vim
source ~/.config/nvim/core/autocmd.vim
source ~/.config/nvim/core/mappings.vim

"------------------------
" ======= Plugins =======
"------------------------
" Auto-completion:
source ~/.config/nvim/plugins/nvim-cmp.lua

" LSP
source ~/.config/nvim/plugins/lsp/lsp-config.vim
source ~/.config/nvim/plugins/lsp/python-lsp.lua
source ~/.config/nvim/plugins/lsp/texlab-lsp.lua

" Git integration
source ~/.config/nvim/plugins/vim-fugitive.vim

" Highlighting
source ~/.config/nvim/plugins/tree-sitter.vim

" Renamer
source ~/.config/nvim/plugins/renamer.lua

" File searcher
source ~/.config/nvim/plugins/telescope.lua

" File tree viewer
source ~/.config/nvim/plugins/nvim-tree.lua

" Tabs
source ~/.config/nvim/plugins/barbar.vim

" Snippets
source ~/.config/nvim/plugins/luasnip.lua

" Notes/prose:
source ~/.config/nvim/plugins/vimwiki.vim
source ~/.config/nvim/plugins/goyo.vim

" VimTeX
"source ~/.config/nvim/plugins/vimtex.vim
