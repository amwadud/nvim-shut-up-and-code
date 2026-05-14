return {
    { 'nvim-lua/plenary.nvim' },
    { 'neovim/nvim-lspconfig', event = 'VeryLazy' },
    { 'williamboman/mason.nvim', cmd = 'Mason' },
    { 'williamboman/mason-lspconfig.nvim', event = 'VeryLazy' },
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = 'VeryLazy',
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup({
                preset = 'classic',
                transparent_bg = true,
            })
            vim.diagnostic.config({ virtual_text = false })
        end,
    },
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({
                symbol_in_winbar = { enable = false },
                ui = { code_action = '' },
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')
            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
                python = { 'flake8' },
                sh = { 'shellcheck' },
                lua = { 'selene' },
            }
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = vim.api.nvim_create_augroup('lint', { clear = true }),
                callback = function()
                    if vim.bo.modifiable then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'mason-org/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
            'leoluz/nvim-dap-go',
        },
        keys = {
            { '<F5>', function() require('dap').continue() end },
            { '<F1>', function() require('dap').step_into() end },
            { '<F2>', function() require('dap').step_over() end },
            { '<F3>', function() require('dap').step_out() end },
            { '<F6>', function() require('dapui').toggle() end },
            { '<leader>db', function() require('dap').toggle_breakpoint() end },
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            require('mason-nvim-dap').setup { automatic_installation = true, ensure_installed = { 'delve' } }
            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            require('dap-go').setup { delve = { detached = vim.fn.has 'win32' == 0 } }
        end,
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = { 'mfussenegger/nvim-dap' },
        ft = 'python',
        config = function()
            require('dap-python').setup 'python3'
        end,
    },
}
