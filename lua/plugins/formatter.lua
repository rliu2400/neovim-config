return {
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
                latex = {
                    function()
                        return {
                            exe = "latexindent",
                            args = { "-w", vim.api.nvim_buf_get_name(0) },
                            stdin = true,
                        }
                    end,
                },
                rust = {
                    function()
                        return {
                            exe = "rustfmt",
                            args = { "--edition 2021" },
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
}
