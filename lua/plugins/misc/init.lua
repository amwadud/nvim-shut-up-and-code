return {
    { import = 'plugins.misc.ai' },
    { import = 'plugins.misc.haunt' },
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
                        should_highlight_line = false, should_highlight_color = false,
                        transform_color = false, on_attach = false, on_detach = false,
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
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        opts = {},
    },
}
