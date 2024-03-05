vim.keymap.set({ 'n', 'i' }, '<Home>', function()
  local _, c = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd 'normal! ^'
  local _, c1 = unpack(vim.api.nvim_win_get_cursor(0))
  if c == c1 then
    vim.cmd 'normal! 0'
  end
end, { desc = 'jump to start of line or first char in line' })

vim.keymap.set('n', '<C-S>', ':w<CR>', { silent = true, desc = 'Save with ctrl + s in normal mode' })
vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>', { silent = true, desc = 'Save with ctrl + s in insert mode' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'paste from clipboard' })
vim.keymap.set('n', '<C-E>', '<C-I>', { desc = 'jump forward alias' })

-- remove trailing whitespace
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[%s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
  end,
  desc = 'remove trailing whitespace',
})

vim.keymap.set({ 'n' }, '<leader>l', function()
  if vim.api.nvim_get_option 'hls' then
    vim.api.nvim_set_option('hls', false)
  else
    if vim.api.nvim_get_current_line() == '' then
      return
    end
    vim.api.nvim_set_option('hls', true)
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd 'normal! *'
    vim.api.nvim_win_set_cursor(0, pos)
  end
end, { desc = 'highlight word under cursor' })

vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = 'Alias for [S]earch by [G]rep' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Alias for [S]earch [F]iles' })

vim.o.colorcolumn = '101'

-- <C-h> is what really maps Ctrl + Backspace because that's what the terminal sends to the editor
vim.keymap.set('i', '<C-BS>', '<C-w>', { desc = 'Delete word in insert mode with Ctrl Backspace part 1' })
vim.keymap.set('i', '<C-h>', '<C-w>', { desc = 'Delete word in insert mode with Ctrl Backspace part 2' })
vim.keymap.set('i', '<C-Del>', '<C-O>dw', { desc = 'Delete word in insert mode with Ctrl Del' })

vim.keymap.set('n', '<leader>i', 'ciw', { desc = 'Alias for ciw' })
vim.keymap.set('n', '<leader>m', '<C-w>', { desc = 'Alias for Ctrl w' })

require 'lush_theme.roy-colors'
vim.cmd.colorscheme 'roy-colors'

-- set tabwith to 4 for golang
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  command = 'setlocal tabstop=4',
})

-- set tabwith to 4 for shellscripts
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  command = 'setlocal tabstop=4',
})

vim.keymap.set('n', '<leader>cf', ':!cargo fmt<CR><CR>', { desc = 'cargo fmt' })
