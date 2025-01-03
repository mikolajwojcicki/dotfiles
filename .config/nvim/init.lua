-- Lightweight nvim setup for development
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
                {out, "WarningMsg"},
                {"\nPress any key to exit..."}
            },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
    {
        spec = {
            -- add your plugins here
            {
                "neovim/nvim-lspconfig",
                config = function()
                    require('lspconfig').pylsp.setup{}
                end
            },
            {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup()
                end
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason-lspconfig").setup()
                end
            },
            {
                "kyazdani42/nvim-tree.lua",
                config = function()
                    require("nvim-tree").setup()
                    vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
                end
            },
            {
                "akinsho/toggleterm.nvim",
                config = function()
                    require("toggleterm").setup {
                        shell = "fish", -- Set the default shell to fish
                        open_mapping = [[<c-\>]]
                    }
                end
            },
            {
                "glepnir/lspsaga.nvim",
                config = function()
                    require("lspsaga").setup()
                end
            },
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip").setup()
                end
            },
            {
                "folke/which-key.nvim",
                event = "VeryLazy",
                opts = {},
                keys = {
                    {
                        "<leader>?",
                        function()
                            require("which-key").show({global = false})
                        end,
                        desc = "Buffer Local Keymaps (which-key)"
                    }
                }
            },
            {
                "folke/tokyonight.nvim",
                lazy = true,
                priority = 1000,
                opts = { style = "moon" }
            }
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = {colorscheme = {"tokyonight"}},
        -- automatically check for plugin updates
        checker = {enabled = true}
    }
)
vim.cmd('colorscheme tokyonight')
