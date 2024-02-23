local commands = {
    [".tex"] = "pdflatex %",  -- Use '%' to represent the current file path
}

function on_write_file()
    local buf_name = vim.api.nvim_buf_get_name(0)

    for pattern, command in pairs(commands) do
        if buf_name:match("^.+%" .. pattern .. "$") ~= nil then
            command = string.gsub(command, "%%", buf_name)  -- Substitute '%' with the actual path
            vim.fn.system(command)
            break
        end
    end
end

vim.api.nvim_command('autocmd BufWritePost * :lua on_write_file()')
