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

    -- Autocompletion plugins
    {
        "hrsh7th/nvim-cmp", -- Autocompletion
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path", -- Path source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn.pumvisible() == 0 then
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_selected_entry() then
                            cmp.confirm({ select = true })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
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

    -- Mason for managing LSP servers, linters, and formatters
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "jdtls", "ts_ls", "html", "cssls", "jsonls", "texlab" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local servers = { "clangd", "pyright", "jdtls", "ts_ls", "html", "cssls", "jsonls", "texlab" }
            for _, server in ipairs(servers) do
                lspconfig[server].setup({})
            end
        end,
    },

    -- Formatting with formatter.nvim
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup({
                filetype = {
                    lua = {
                        function()
                            return {
                                exe = "stylua",
                                args = { "--config-path", vim.fn.expand("~/.config/stylua.toml"), "-" },
                                stdin = true,
                            }
                        end,
                    },
                    python = {
                        function()
                            return {
                                exe = "black",
                                args = { "--fast", "-" },
                                stdin = true,
                            }
                        end,
                    },
                    cpp = {
                        function()
                            return {
                                exe = "clang-format",
                                args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
                                stdin = true,
                            }
                        end,
                    },
                    javascript = {
                        function()
                            return {
                                exe = "prettier",
                                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                                stdin = true,
                            }
                        end,
                    },
                },
            })
            -- Auto-format on save
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "*",
                callback = function()
                    vim.cmd("FormatWrite")
                end,
            })
        end,
    },

    -- Linting with nvim-lint
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "flake8" },
                javascript = { "eslint" },
                typescript = { "eslint" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },

    -- Git integration
    { "tpope/vim-fugitive" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
})

-- Set tab settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true

-- Python host program
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- Required dependencies:
-- Install Mason-managed LSPs and formatters: clangd, pyright, jdtls, ts_ls, html, cssls, jsonls, texlab
-- Install external formatters: stylua, black, clang-format, prettier
-- Install external linters: flake8, eslint
-- Ensure lazy.nvim is installed for package management
-- Optional: Install luacheck if you want Lua linting

