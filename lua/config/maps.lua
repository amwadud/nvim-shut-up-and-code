local map = vim.keymap.set

-- Ctrl keys
map('n', '<C-s>', '<CMD>w<CR>', { desc = 'Save' })
map('n', '<C-q>', '<CMD>q<CR>', { desc = 'Quit' })
map({ 'n', 'v' }, '<C-f>', function()
    require('conform').format({ async = true })
end, { desc = 'Format' })

-- Oil
map('n', '-', '<CMD>Oil<CR>', { desc = 'Parent dir' })

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Move lines
map('n', '<A-j>', '<CMD>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', '<CMD>m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Telescope
map('n', 'tt', '<CMD>Telescope<CR>', { desc = 'Telescope' })
map('n', 'tf', '<CMD>Telescope find_files<CR>', { desc = 'Find files' })
map('n', 'tg', '<CMD>Telescope live_grep<CR>', { desc = 'Live grep' })
map('n', 'tb', '<CMD>Telescope buffers<CR>', { desc = 'Buffers' })
map('n', 'tr', '<CMD>Telescope resume<CR>', { desc = 'Resume' })
map('n', 'th', '<CMD>Telescope help_tags<CR>', { desc = 'Help tags' })
map('n', 'ts', '<CMD>Telescope grep_string<CR>', { desc = 'Grep string' })
map('n', 'tc', '<CMD>Telescope commands<CR>', { desc = 'Commands' })
map('n', 'tm', '<CMD>Telescope marks<CR>', { desc = 'Marks' })
map('n', 'to', '<CMD>Telescope oldfiles<CR>', { desc = 'Old files' })
map('n', 'td', '<CMD>Telescope diagnostics<CR>', { desc = 'Diagnostics' })
map('n', 'tG', '<CMD>Telescope git_files<CR>', { desc = 'Git files' })
map('n', 'tgs', '<CMD>Telescope git_status<CR>', { desc = 'Git status' })
map('n', 'tgb', '<CMD>Telescope git_branches<CR>', { desc = 'Git branches' })
map('n', 'tgl', '<CMD>Telescope git_log<CR>', { desc = 'Git log' })

-- Trouble
map('n', '<leader>xx', '<CMD>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics' })
map('n', '<leader>xX', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diagnostics' })
map('n', '<leader>xs', '<CMD>Trouble symbols toggle focus=false<CR>', { desc = 'Symbols' })
map('n', '<leader>xl', '<CMD>Trouble lsp toggle focus=false<CR>', { desc = 'LSP references' })

-- Splits: create
map('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>sx', '<C-w>c', { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize splits' })

-- Splits: resize
map('n', '<M-,>', '<C-w>3<', { desc = 'Shrink width' })
map('n', '<M-.>', '<C-w>3>', { desc = 'Expand width' })
map('n', '<M-->', '<C-w>3-', { desc = 'Shrink height' })
map('n', '<M-=>', '<C-w>3+', { desc = 'Expand height' })

-- Lspsaga
map('n', 'K', '<CMD>Lspsaga hover_doc<CR>')

-- Glance
map('n', 'gD', '<CMD>Glance definitions<CR>')
map('n', 'gR', '<CMD>Glance references<CR>')
map('n', 'gY', '<CMD>Glance type_definitions<CR>')
map('n', 'gM', '<CMD>Glance implementations<CR>')

-- Go to preview
map('n', 'gp', '<cmd>lua require(\'goto-preview\').goto_preview_definition()<CR>', { desc = 'Preview definition' })

