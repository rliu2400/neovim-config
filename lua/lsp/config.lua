local lspconfig = require("lspconfig")
local servers = { "clangd", "pyright", "jdtls", "ts_ls", "html", "cssls", "jsonls", "texlab" }
for _, server in ipairs(servers) do
    lspconfig[server].setup({})
end
