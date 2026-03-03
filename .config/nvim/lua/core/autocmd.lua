-- Automatically deletes all trailing whitespace and newlines at end of file on save.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd([[%s/\s\+$//e]])
    end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd([[%s/\n\+\%$//e]])
    end,
})

-- Runs a script that cleans out tex build files whenever I close out of a .tex file.
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*.tex",
    callback = function()
        vim.cmd("!texclear %")
    end,
})

-- Disables automatic commenting on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})
