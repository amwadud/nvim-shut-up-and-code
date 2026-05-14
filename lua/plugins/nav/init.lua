return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        opts = {
            defaults = {
                selection_caret = ' ',
                sorting_strategy = 'ascending',
                layout_config = { prompt_position = 'top' },
                prompt_prefix = '   ',
                mappings = { i = { ['<C-j>'] = 'move_selection_next', ['<C-k>'] = 'move_selection_previous' } },
            },
        },
    },
    {
        'rmagatti/goto-preview',
        dependencies = { 'rmagatti/logger.nvim' },
        event = 'BufEnter',
        config = true,
    },
    {
        'chrisgrieser/nvim-spider',
        keys = {
            { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
            { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
            { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
            { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'n', 'o', 'x' } },
        },
    },
    {
        'amwadud/nvim-maximizer',
        keys = { { '<C-m>', '<cmd>MaximizerToggle<CR>' } },
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
        end,
        keys = { { '-', '<CMD>Oil<CR>' } },
    },
    {
        'JezerM/oil-lsp-diagnostics.nvim',
        event = 'VeryLazy',
        dependencies = { 'stevearc/oil.nvim' },
        opts = {},
    },
    {
        'benomahony/oil-git.nvim',
        event = 'VeryLazy',
        dependencies = { 'stevearc/oil.nvim' },
    },
    {
        'ggandor/leap.nvim',
        lazy = true,
        keys = {
            {
                'f',
                function()
                    require('leap').leap({
                        target_windows = vim.tbl_filter(function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'oil'
                        end, vim.api.nvim_list_wins()),
                    })
                end,
            },
            {
                'F',
                function()
                    require('leap').leap({
                        target_windows = vim.tbl_filter(function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'oil'
                        end, vim.api.nvim_list_wins()),
                        backward = true,
                    })
                end,
            },
        },
    },
    {
        'folke/flash.nvim',
        lazy = true,
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
            },
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
            },
        },
    },
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'dnlhc/glance.nvim',
        cmd = 'Glance',
    },
    {
        'ya2s/nvim-cursorline',
        opts = {
            disable_filetypes = { 'oil' },
        },
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup()

            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end)

            vim.keymap.set('n', '<leader>e', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set('n', '<leader>1', function()
                harpoon:list():select(1)
            end)
            vim.keymap.set('n', '<leader>2', function()
                harpoon:list():select(2)
            end)
            vim.keymap.set('n', '<leader>3', function()
                harpoon:list():select(3)
            end)
            vim.keymap.set('n', '<leader>4', function()
                harpoon:list():select(4)
            end)
        end,
    },
    {
        'amwadud/quicksearch.nvim',
        config = function()
            require('quicksearch').setup()
        end,
    },
    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp',
            'TmuxNavigateRight', 'TmuxNavigatePrevious', 'TmuxNavigatorProcessList',
        },
        keys = {
            { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
            { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
        },
    },
}
