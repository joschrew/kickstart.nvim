vim.keymap.set({'n', 'i'}, '<Home>', function()
    local _,c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd('normal! ^')
    local _,c1 = unpack(vim.api.nvim_win_get_cursor(0))
    if c == c1 then
        vim.cmd('normal! 0')
    end
end, { desc = 'jump to start of line or first char in line' })

vim.keymap.set('n', '<C-S>', ':w<CR>', { silent = true, desc = 'Save with ctrl + s in normal mode' })
vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>', { silent = true, desc = 'Save with ctrl + s in insert mode' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'paste from clipboard' })

-- remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[%s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, pos)
    end
})

-- search with leader g and f in addition to leader sg and sf
vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep 2' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles 2' })

vim.o.colorcolumn="101"

-- <C-h> is also neccessary, no idea why
vim.keymap.set('i', '<C-BS>', '<C-w>', { desc = 'Delete word in insert mode with Ctrl Backspace part 1'})
vim.keymap.set('i', '<C-h>', '<C-w>', { desc = 'Delete word in insert mode with Ctrl Backspace part 2'})
vim.keymap.set('i', '<C-Del>', '<C-O>dw', { desc = 'Delete word in insert mode with Ctrl Del'})
