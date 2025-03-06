-- ~/.config/nvim/lua/plugins/statusline.lua
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "moonfly",
                section_separators = "",
                component_separators = "|",
            },
        })
    end,
}
