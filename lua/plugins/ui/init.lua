return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_material_background = 'soft'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    { 'maxmx03/solarized.nvim' },
    {
        'ember-theme/nvim',
        name = 'ember',
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            notifier = { enabled = true },
            picker = { expand = true },
            animate = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            dashboard = { enabled = false },
            bigfile = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = {
                enabled = true,
                left = { 'mark', 'sign', 'git' },
                right = { 'fold' },
                folds = { open = true, git_hl = false },
                git = { patterns = { 'GitSign', 'MiniDiffSign' } },
                refresh = 50,
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            local function get_hl(group, attr)
                local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
                return ok and val and string.format('#%06x', val[attr])
            end

            local function get_colors()
                return {
                    fg = get_hl('Normal', 'fg') or '#657b83',
                    bg = get_hl('Normal', 'bg') or '#002b36',
                    comment = get_hl('Comment', 'fg') or '#93a1a1',
                    warning = get_hl('DiagnosticWarn', 'fg') or '#b58900',
                    error = get_hl('DiagnosticError', 'fg') or '#dc322f',
                    green = get_hl('DiagnosticOk', 'fg') or '#859900',
                    cyan = get_hl('Function', 'fg') or '#268bd2',
                }
            end

            local function col(fg_key)
                return function()
                    local c = get_colors()
                    return { fg = c[fg_key], bg = c.bg }
                end
            end

            local function get_theme()
                local c = get_colors()
                local active = { fg = c.fg, bg = c.bg }
                local inactive = { fg = c.comment, bg = c.bg }
                return {
                    normal = { a = active, b = active, c = active },
                    insert = { a = active, b = active, c = active },
                    visual = { a = active, b = active, c = active },
                    replace = { a = active, b = active, c = active },
                    command = { a = active, b = active, c = active },
                    inactive = { a = inactive, b = inactive, c = inactive },
                }
            end

            local function filepath()
                local rel = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~:.')
                return rel == '' and '[No Name]' or rel
            end

            local function filepath_color()
                local c = get_colors()
                if vim.fn.expand('%:t') == '' or vim.bo.modified then
                    return { fg = c.warning, bg = c.bg }
                end
                return { fg = c.fg, bg = c.bg }
            end

            local function lsp_component()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return '󰒋 none' end
                return '󰒋 ' .. table.concat(vim.tbl_map(function(c) return c.name end, clients), ', ')
            end

            local function lsp_color()
                local c = get_colors()
                return { fg = #vim.lsp.get_clients({ bufnr = 0 }) == 0 and c.comment or c.cyan, bg = c.bg }
            end

            local function formatter_component()
                local ok, conform = pcall(require, 'conform')
                local formatters = ok and conform.list_formatters(0) or {}
                if #formatters == 0 then return '󰉿 none' end
                return '󰉿 ' .. table.concat(vim.tbl_map(function(f) return f.name end, formatters), ', ')
            end

            local function formatter_color()
                local c = get_colors()
                local ok, conform = pcall(require, 'conform')
                local formatters = ok and conform.list_formatters(0) or {}
                return { fg = #formatters == 0 and c.comment or c.fg, bg = c.bg }
            end

            local function linter_component()
                local ok, lint = pcall(require, 'lint')
                local linters = ok and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
                if #linters == 0 then return '󱉶 none' end
                return '󱉶 ' .. table.concat(linters, ', ')
            end

            local function linter_color()
                local c = get_colors()
                local ok, lint = pcall(require, 'lint')
                local linters = ok and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
                return { fg = #linters == 0 and c.comment or c.warning, bg = c.bg }
            end

            local function buffer_count()
                local bufs = vim.fn.getbufinfo({ buflisted = 1 })
                return #bufs <= 1 and '' or '󰓩 ' .. #bufs
            end

            local function macro_recording()
                local reg = vim.fn.reg_recording()
                return reg == '' and '' or '󰑊 @' .. reg
            end

            return {
                options = {
                    theme = get_theme,
                    globalstatus = true,
                    component_separators = '',
                    section_separators = '',
                    disabled_filetypes = { statusline = { 'dashboard', 'oil' } },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { { 'branch', icon = ' ', color = col('comment') } },
                    lualine_c = {
                        { filepath, icon = '󰈔 ', color = filepath_color },
                        { macro_recording, color = col('warning') },
                    },
                    lualine_x = {
                        { 'diagnostics', symbols = { error = '󰅙 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' } },
                        { lsp_component, color = lsp_color },
                        { formatter_component, color = formatter_color },
                        { linter_component, color = linter_color },
                        { buffer_count, color = col('comment') },
                    },
                    lualine_y = {},
                    lualine_z = {},
                },
            }
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = false,
            },
            cmdline = {
                format = {
                    cmdline = { pattern = '^:', icon = ' ', lang = 'vim' },
                    search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
                    search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
                    filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
                    lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
                    help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
                    input = { view = 'cmdline_input', icon = '󰥻 ' },
                },
            },
            views = {
                cmdline_popup = {
                    position = { row = 0, col = '50%' },
                    size = { width = '40%', height = 'auto' },
                    border = { style = 'none', padding = { 0, 1 } },
                    win_options = { winhighlight = 'Normal:NormalFloat,FloatBorder:NormalFloat' },
                },
                popupmenu = {
                    relative = 'editor',
                    position = { row = 1, col = '50%' },
                    size = { width = '40%', height = 10 },
                    border = { style = 'none', padding = { 0, 1 } },
                },
            },
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'amansingh-afk/milli.nvim' },
        opts = function()
            local splash = require('milli').load({ splash = 'finger' })
            return {
                theme = 'doom',
                config = {
                    header = splash.frames[1],
                    center = {
                        { icon = '  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
                        { icon = '  ', desc = 'Quit', key = 'q', action = 'qa' },
                    },
                },
            }
        end,
        config = function(_, opts)
            require('dashboard').setup(opts)
            require('milli').dashboard({ splash = 'finger', loop = true })
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show { global = false }
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
    {
        'gbprod/yanky.nvim',
        opts = {},
    },
    {
        'lukas-reineke/virt-column.nvim',
        opts = {
            char = '│',
            highlight = 'VirtColumn',
        },
    },
    {
        'stevearc/quicker.nvim',
        ft = 'qf',
        opts = {},
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'kungfusheep/mfd.nvim' },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        opts = {
            default = true,
            color_icons = false,
        },
    },
}
