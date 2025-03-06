-- ~/.config/nvim/lua/plugins/snippets.lua
return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip").config.set_config({
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })
    end,
}
