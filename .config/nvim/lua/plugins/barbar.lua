--  Move to previous/next
vim.keymap.set("n", "<M-,>", "<Cmd>BufferPrevious<CR>", {silent = true})
vim.keymap.set("n", "<M-.>", "<Cmd>BufferNext<CR>", {silent = true})

-- Re-order to previous/next
vim.keymap.set("n", "<M-s-,>", "<Cmd>BufferMovePrevious<CR>", {silent = true})
vim.keymap.set("n", "<M-s-.>", "<Cmd>BufferMoveNext<CR>", {silent = true})

-- Goto buffer in position...
vim.keymap.set("n", "<M-1>", "<Cmd>BufferGoto 1<CR>", {silent = true})
vim.keymap.set("n", "<M-2>", "<Cmd>BufferGoto 2<CR>", {silent = true})
vim.keymap.set("n", "<M-3>", "<Cmd>BufferGoto 3<CR>", {silent = true})
vim.keymap.set("n", "<M-4>", "<Cmd>BufferGoto 4<CR>", {silent = true})
vim.keymap.set("n", "<M-5>", "<Cmd>BufferGoto 5<CR>", {silent = true})
vim.keymap.set("n", "<M-6>", "<Cmd>BufferGoto 6<CR>", {silent = true})
vim.keymap.set("n", "<M-7>", "<Cmd>BufferGoto 7<CR>", {silent = true})
vim.keymap.set("n", "<M-8>", "<Cmd>BufferGoto 8<CR>", {silent = true})
vim.keymap.set("n", "<M-9>", "<Cmd>BufferGoto 9<CR>", {silent = true})
vim.keymap.set("n", "<M-0>", "<Cmd>BufferGoto 0<CR>", {silent = true})

-- Pin/unpin buffer
-- nnoremap <silent>    <M-s-p> <Cmd>BufferPin<CR>

-- Close buffer
vim.keymap.set("n", "<M-w>", "<Cmd>BufferClose<CR>", {silent = true})
-- Restore buffer
vim.keymap.set("n", "<M-s-t>", "<Cmd>BufferRestore<CR>", {silent = true})

-- Wipeout buffer
--                          :BufferWipeout
-- Close commands
--                          :BufferCloseAllButCurrent
--                          :BufferCloseAllButVisible
--                          :BufferCloseAllButPinned
--                          :BufferCloseAllButCurrentOrPinned
--                          :BufferCloseBuffersLeft
--                          :BufferCloseBuffersRight

-- Magic buffer-picking mode
vim.keymap.set("n", "<M-s-p>" , "<Cmd>BufferPick<CR>", {silent = true})
-- nnoremap <silent> <C-w>    <Cmd>BufferPickDelete<CR>

-- Sort automatically by...
vim.keymap.set("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", {silent = true})
vim.keymap.set("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", {silent = true})
vim.keymap.set("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", {silent = true})
vim.keymap.set("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", {silent = true})

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
