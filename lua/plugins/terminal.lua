-- ~/.config/nvim/lua/plugins/terminal.lua
return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = function()
                return vim.o.columns * 0.5
            end,
            open_mapping = [[<C-t>]],
            direction = "vertical",
            persist_size = true,
            start_in_insert = true,
        })
    end,
}
