require("lazy").setup({
    require("plugins.colorscheme"),

    require("plugins.completion"),
    require("plugins.terminal"),
    require("plugins.vimtex"),
    require("plugins.autopairs"),

    require("plugins.lsp"),
    require("plugins.formatter"),
    require("plugins.linter"),

    require("plugins.git"),

    require("plugins.filetree"),
    require("plugins.statusline"),
    require("plugins.snippets"),
    require("plugins.telescope"),
    -- require("plugins.lspsaga"),
})
