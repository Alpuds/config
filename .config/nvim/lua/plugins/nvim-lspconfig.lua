-- LSP config (the mappings used in the default file don't quite work right)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {silent = true})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {silent = true})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {silent = true})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {silent = true})
vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, {silent = true})
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {silent = true})
vim.keymap.set("n", "gl", vim.diagnostic.open_float, {silent = true})
vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, {silent = true})
vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, {silent = true})

-- Specify how the border looks like
local border = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
}

-- Add border to hover
vim.opt.winborder = "single"

-- Add border to the diagnostic popup window
vim.diagnostic.config({
    virtual_text = {
        prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
    },
    float = { border = border },
})
