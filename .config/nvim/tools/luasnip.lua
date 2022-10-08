local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    -- This tels LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even ifyou move outside of uthe selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true,

    -- Crazy highlights!!
    -- #vid3
    -- ext_opts = nil,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "🠐", "Hmm" } }
            }
        }
    }
    }

-- This will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- This always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- This is useful for choice nodes
vim.keymap.set("i", "<a-c>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

require("luasnip.loaders.from_snipmate").load({ paths = { "./tools/snippets" } })
