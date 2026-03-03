-- Ensure files are read as what I want
vim.g.vimwiki_ext2syntax = {
    ['.Rmd'] = 'markdown',
    ['.rmd'] = 'markdown',
    ['.md'] = 'markdown',
    ['.markdown'] =  'markdown',
    ['.mdown'] =  'markdown',
}

vim.g.vimwiki_list = {
    {
        path = "~/.local/share/vimwiki",
        syntax = "markdown",
        ext = "md",
    },
    {
        path = "another directory",
        syntax = "markdown",
        ext = "md",
    },
}

vim.g.vimwiki_global_ext = 0

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"},{
    pattern = {"*.ms", "*.me", "*.mom", "*.man"},
    callback = function()
        vim.bo.filetype = "groff"
    end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.tex",
    callback = function()
        vim.bo.filetype = "tex"
    end,
})

vim.keymap.set("n", "<leader>v", ":VimwikiIndex<CR>")
vim.keymap.set("n", "<leader>vs", ":VimwikiUISelect<CR>")
