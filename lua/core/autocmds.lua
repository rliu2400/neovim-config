vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
        vim.cmd("FormatWrite")
    end,
})

vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        -- Check if the buffer is a terminal buffer
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("^term://") then
            -- Use the terminal's working directory (from shell command)
            local cwd = vim.fn.systemlist("pwd")[1]
            if cwd and cwd ~= "" then
                vim.cmd("lcd " .. vim.fn.fnameescape(cwd))
            end
        end
    end,
})
