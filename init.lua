-- Neovim configuration using lazy.nvim as the package manager
-- Ensure you have lazy.nvim installed before proceeding

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy").setup({
    -- Colorscheme: tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    -- LSP and autocompletion plugins
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp", -- Autocompletion
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path", -- Path source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
            "L3MON4D3/LuaSnip", -- Snippets plugin
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- Configure LSP servers
            lspconfig.clangd.setup({}) -- C++       check ~/.clangd for compile commands
            lspconfig.pyright.setup({}) -- Python
            lspconfig.jdtls.setup({}) -- Java
            lspconfig.ts_ls.setup({}) -- JavaScript and TypeScript
            lspconfig.html.setup({}) -- HTML
            lspconfig.cssls.setup({}) -- CSS
            lspconfig.jsonls.setup({}) -- JSON
            lspconfig.texlab.setup({ -- LaTeX
                settings = {
                    latex = {
                        build = {
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = "zathura",
                            args = { "--synctex-forward", "%l:1:%f", "%p" },
                        },
                    },
                },
            })

            -- Autocompletion configuration
            local cmp = require("cmp")
            cmp.setup({
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },

    -- File navigator
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- Optional for file icons
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- Git integration
    {
        "tpope/vim-fugitive", -- Git commands
    },
    {
        "lewis6991/gitsigns.nvim", -- Git status in the UI
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    section_separators = "",
                    component_separators = "|",
                },
            })
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Indent Guides
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({})
        end,
    },
    -- Lua Formatter
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup({
                filetype = {
                    lua = {
                        function()
                            return {
                                exe = "stylua",
                                args = {
                                    "--indent-width",
                                    "4",
                                    "--indent-type",
                                    "Spaces",
                                    "-",
                                },
                                stdin = true,
                            }
                        end,
                    },
                },
            })

            -- Automatically format on save
            vim.api.nvim_exec(
                [[
                augroup FormatAutogroup
                    autocmd!
                    autocmd BufWritePost *.lua FormatWrite
                augroup END
            ]],
                true
            )
        end,
    },

    -- Terminal integration
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                direction = "horizontal",
                persist_size = true,
                close_on_exit = true,
            })
        end,
    },
})

-- Set tab settings
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces for each indentation
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.opt.number = true

-- Dependencies installation instructions:
-- 1. Install Neovim (v0.8+ recommended) via Homebrew: `brew install neovim`
-- 2. Install language server binaries:
--    - C++: clangd
--    - Python: pyright (`npm install -g pyright`)
--    - Java: jdtls
--    - JavaScript/TypeScript: typescript-language-server (`npm install -g typescript typescript-language-server`)
--    - HTML/CSS/JSON: vscode-html-languageserver, vscode-css-languageserver, vscode-json-languageserver (`npm install -g vscode-langservers-extracted`)
--    - LaTeX: texlab (`brew install texlab`)
-- 3. Install Zathura for PDF preview: `brew install zathura`
-- 4. Clone this configuration into `~/.config/nvim/init.lua`
-- 5. Install Stylua for Lua formatting: `brew install stylua`
