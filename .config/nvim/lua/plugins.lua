-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { -- Coding
            "neovim/nvim-lspconfig",
            dependencies = {
                {
                    "williamboman/mason.nvim",
                    opts = {},
                },
                {
                    "williamboman/mason-lspconfig",
                    opts = {},
                },
            },
            config = function()
                require("plugins.nvim-lspconfig")
            end
        },
        {
            "mhartington/formatter.nvim",
            event = "VeryLazy",
            config = function()
                require("plugins.formatter")
            end
        },
        {
            "filipdutescu/renamer.nvim",
            keys = { {"<leader>rn", "<Cmd>lua require('renamer').rename()<CR>"} },
            config = function()
                require("plugins.renamer")
            end
        },
        "jiangmiao/auto-pairs",
        "tpope/vim-commentary",
        "tpope/vim-surround",
        {
            "nvim-treesitter/nvim-treesitter",
            lazy = false,
            build = ':TSUpdate',
            config = function()
                require("plugins.nvim-treesitter")
            end
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            lazy = false,
            config = function()
                require("ibl").setup()
            end
            -- opts = {}, throws an error
        },
        -- Git integration
        {
            "tpope/vim-fugitive",
            cmd = "G",
            keys = { {"<leader>g", "<Cmd>G<CR>"} },
            config = function()
                require("plugins.vim-fugitive")
            end
        },
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("plugins.gitsigns")
            end
        },
        -- Auto-completion
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                {
                    "L3MON4D3/LuaSnip",
                    -- follow latest release.
                    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                    -- install jsregexp (optional!).
                    build = "make install_jsregexp",
                    config = function()
                        require("plugins.luasnip")
                    end
                },
                {
                    "saadparwaiz1/cmp_luasnip",
                },
                {
                    "onsails/lspkind-nvim",
                },
            },
            config = function()
                require("plugins.nvim-cmp")
            end
        },
        -- File tree viewer
        {
            "nvim-tree/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            keys = { {"<leader>t", "<Cmd>NvimTreeToggle<CR>"} },
            config = function()
                require("plugins.nvim-tree")
            end
        },
        {
            "nvim-tree/nvim-web-devicons",
            lazy = false,
            priority = 100,
            config = function()
                require("plugins.nvim-web-devicons")
            end
        },
        {
            'nvim-telescope/telescope.nvim', version = '*',
            cmd = "Telescope",
            keys = { {"<leader>ff", "<Cmd>Telescope find_files<CR>"} },
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- optional but recommended
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            },
            config = function()
                require("plugins.telescope")
            end
        },
        -- Visual enhancements
        {
            "ellisonleao/gruvbox.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("themes.gruvbox")
            end
        },
        {
            "nvim-lualine/lualine.nvim",
            lazy = false,
            priority = 100,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
        },
        {
            "catgoose/nvim-colorizer.lua",
            lazy = false,
            priority = 200,
            config = function()
                require'colorizer'.setup()
            end
        },
        {
            "romgrk/barbar.nvim",
            lazy = false,
            priority = 50,
            config = function()
                require("plugins.barbar")
            end
        },
        -- Prose
        {
            "vimwiki/vimwiki",
            init = function()
                require("plugins.vimwiki")
            end
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "gruvbox" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
