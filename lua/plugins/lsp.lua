return {
    -- The main LSP plugin
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "clangd",
                        "pyright",
                        "jdtls",
                        "ts_ls",
                        "html",
                        "cssls",
                        "jsonls",
                        "texlab",
                    },
                })
            end,
        },
    },
    config = function()
        -- After mason-lspconfig’s setup above, just do normal lspconfig setups:
        local lspconfig = require("lspconfig")
        local servers = {
            "clangd",
            "pyright",
            "jdtls",
            "ts_ls",
            "html",
            "cssls",
            "jsonls",
            "texlab",
        }
        for _, server in ipairs(servers) do
            lspconfig[server].setup({})
        end
    end,
}
