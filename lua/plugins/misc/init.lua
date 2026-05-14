return {
    {
        'ThePrimeagen/99',
        config = function()
            local _99 = require('99')
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                model = 'opencode/big-pickle',
                logger = {
                    level = _99.DEBUG,
                    path = '/tmp/' .. basename .. '.99.debug',
                    print_on_error = true,
                },
                tmp_dir = './tmp',
                completion = {
                    custom_rules = { 'scratch/custom_rules/' },
                    files = {},
                    source = 'native',
                },
                md_files = { 'AGENT.md' },
            })

            vim.keymap.set('v', '<leader>9v', function()
                _99.visual()
                vim.cmd('startinsert')
            end, { desc = '99 visual prompt' })

            vim.keymap.set('n', '<leader>9s', function()
                _99.search()
                vim.cmd('startinsert')
            end, { desc = '99 search prompt' })

            vim.keymap.set('n', '<leader>9x', function()
                _99.stop_all_requests()
            end, { desc = '99 cancel' })

            vim.keymap.set('n', '<leader>9m', function()
                require('99.extensions.telescope').select_model()
            end, { desc = '99 select model' })

            vim.keymap.set('n', '<leader>9l', function()
                require('99').view_logs()
            end, { desc = '99 view logs' })
        end,
    },
    {
        'TheNoeTrevino/haunt.nvim',
        opts = {
            sign = '󱙝',
            sign_hl = 'HauntAnnotation',
            virt_text_hl = 'HauntAnnotation',
            annotation_prefix = ' 󰆉 ',
            annotation_suffix = '',
            line_hl = nil,
            virt_text_pos = 'eol',
            data_dir = nil,
            per_branch_bookmarks = true,
            picker = 'auto',
            picker_keys = {
                delete = { key = 'd', mode = { 'n' } },
                edit_annotation = { key = 'a', mode = { 'n' } },
            },
        },
        keys = {
            { '<leader>ha', function() require('haunt.api').annotate() end, desc = 'Annotate' },
            { '<leader>ht', function() require('haunt.api').toggle_annotation() end, desc = 'Toggle annotation' },
            { '<leader>hT', function() require('haunt.api').toggle_all_lines() end, desc = 'Toggle all annotations' },
            { '<leader>hd', function() require('haunt.api').delete() end, desc = 'Delete bookmark' },
            { '<leader>hC', function() require('haunt.api').clear_all() end, desc = 'Delete all bookmarks' },
            { '<leader>hp', function() require('haunt.api').prev() end, desc = 'Previous bookmark' },
            { '<leader>hn', function() require('haunt.api').next() end, desc = 'Next bookmark' },
            { '<leader>hl', function() require('haunt.picker').show() end, desc = 'Show Picker' },
            { '<leader>hq', function() require('haunt.api').to_quickfix() end, desc = 'Send to QF (buffer)' },
            { '<leader>hQ', function() require('haunt.api').to_quickfix({ current_buffer = true }) end, desc = 'Send to QF (all)' },
            { '<leader>hy', function() require('haunt.api').yank_locations({ current_buffer = true }) end, desc = 'Yank locations (buffer)' },
            { '<leader>hY', function() require('haunt.api').yank_locations() end, desc = 'Yank locations (all)' },
        },
        config = function(_, opts)
            require('haunt').setup(opts)
        end,
    },
    {
        'm4xshen/hardtime.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {},
    },
    {
        'catgoose/nvim-colorizer.lua',
        event = 'BufReadPre',
        config = function()
            require('colorizer').setup({
                filetypes = { '*' },
                buftypes = {},
                user_commands = true,
                lazy_load = false,
                options = {
                    parsers = {
                        css = false, css_fn = false,
                        names = { enable = true, lowercase = true, camelcase = true, uppercase = false, strip_digits = false, custom = false, extra_word_chars = '-' },
                        hex = { default = true, rgb = true, rgba = true, rrggbb = true, rrggbbaa = false, hash_aarrggbb = false, aarrggbb = false, no_hash = false },
                        rgb = { enable = false }, hsl = { enable = false }, oklch = { enable = false },
                        hwb = { enable = false }, lab = { enable = false }, lch = { enable = false },
                        css_color = { enable = false },
                        tailwind = { enable = false, update_names = false, lsp = { enable = false, disable_document_color = true } },
                        sass = { enable = false, parsers = { css = true }, variable_pattern = '^%$([%w_-]+)' },
                        xterm = { enable = false }, xcolor = { enable = false }, hsluv = { enable = false },
                        css_var_rgb = { enable = false },
                        css_var = { enable = false, parsers = { css = true } },
                        custom = {},
                    },
                    display = {
                        mode = 'background',
                        background = { bright_fg = '#000000', dark_fg = '#ffffff' },
                        virtualtext = { char = '󰝤', position = 'eol', hl_mode = 'foreground' },
                        priority = { default = 150, lsp = 200 },
                        disable_document_color = true,
                    },
                    hooks = {
                        should_highlight_line = false,
                        should_highlight_color = false,
                        transform_color = false,
                        on_attach = false,
                        on_detach = false,
                    },
                    always_update = false,
                    debounce_ms = 0,
                },
            })
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        opts = {},
    },
    {
        'necrom4/calcium.nvim',
        cmd = { 'Calcium' },
        opts = {},
    },
    {
        '2kabhishek/nerdy.nvim',
        dependencies = { 'folke/snacks.nvim' },
        cmd = 'Nerdy',
        opts = {
            max_recents = 30,
            copy_to_clipboard = false,
            copy_register = '+',
        },
        keys = {
            { '<leader>in', ':Nerdy list<CR>', desc = 'Browse nerd icons' },
            { '<leader>iN', ':Nerdy recents<CR>', desc = 'Browse recent nerd icons' },
        },
    },
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    },
    {
        'nvzone/typr',
        dependencies = 'nvzone/volt',
        opts = {},
        cmd = { 'Typr', 'TyprStats' },
    },
    { 'nvim-mini/mini.nvim', version = '*' },
    {
        'jiaoshijie/undotree',
        opts = {},
        keys = {
            { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },
    {
        'chrscchrn/dictionary.nvim',
        config = function()
            require('dictionary').setup()
        end,
    },
    {
        'kawre/leetcode.nvim',
        build = ':TSUpdate html',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        opts = {},
    },
}
