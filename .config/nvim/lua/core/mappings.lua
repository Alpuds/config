--------------------------
-- ======= Editing =======
--------------------------
-- Control s to save
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- Better tabbing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

--  Map ctrl-o to delete the previous word in insert mode.
vim.keymap.set("i", "<C-o>", "<C-w>", {remap = true})

-- Perform dot commands over visual blocks
vim.keymap.set("v", ".", ":normal .<CR>")

-- Replace ex mode with gq
vim.keymap.set("n", "Q", "gq")
vim.keymap.set("v", "Q", "gq")

-- Replace all is aliased to S.
vim.keymap.set("n", "S", ":%s//g<Left><Left>")

-- Save file as sudo on files that require root permission
vim.keymap.set("c", "w!!", function()
    local cmd = "silent! write !sudo tee % >/dev/null"
    vim.api.nvim_command(cmd)
    -- Feed the "Escape" key to exit command-line mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    vim.api.nvim_command("edit!")
end,
{silent = true}
)

--------------------------
-- ===== Navigation ======
--------------------------
-- File tab navigation
vim.keymap.set("n", "<tab>", ":tabn<CR>")
vim.keymap.set("n", "<S-tab>", ":tabp<CR>")

-- Split navigation, saving a keypress
vim.keymap.set("n", "<C-h", "<C-w>h")
vim.keymap.set("n", "<C-j", "<C-w>j")
vim.keymap.set("n", "<C-k", "<C-w>k")
vim.keymap.set("n", "<C-l", "<C-w>l")

-- Spell-check set to <leader>o, 'o' for 'orthography'
vim.keymap.set("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>")

-- -----------------------
-- === Miscellaneous =====
--------------------------
-- Compile document, be it groff/LaTeX/markdown/etc.
vim.keymap.set("n", "<leader>c", "<Cmd>:w! | !compiler %<CR>")

-- Open corresponding .pdf/.html or preview
vim.keymap.set("n", "<leader>p", "<Cmd>silent :!opout %<CR>", {silent = true})
