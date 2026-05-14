return {
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

            local c = {
                fg = get_hl('Normal', 'fg') or '#d4be98',
                bg = get_hl('Normal', 'bg') or '#32302f',
                comment = get_hl('Comment', 'fg') or '#928374',
                green = get_hl('DiagnosticOk', 'fg') or '#a9b665',
                warning = get_hl('DiagnosticWarn', 'fg') or '#d8a657',
                error = get_hl('DiagnosticError', 'fg') or '#ea6962',
                info = get_hl('DiagnosticInfo', 'fg') or '#7daea3',
                cyan = get_hl('Function', 'fg') or '#7daea3',
            }

            local function lsp_name()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return '' end
                return '󰒋 ' .. table.concat(vim.tbl_map(function(c) return c.name end, clients), ',')
            end

            local function formatter_name()
                local ok, conform = pcall(require, 'conform')
                local f = ok and conform.list_formatters(0) or {}
                if #f == 0 then return '' end
                return '󰉿 ' .. table.concat(vim.tbl_map(function(x) return x.name end, f), ',')
            end

            local function linter_name()
                local ok, lint = pcall(require, 'lint')
                local l = ok and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
                if #l == 0 then return '' end
                return '󱉶 ' .. table.concat(l, ',')
            end

            return {
                options = {
                    theme = {
                        normal = { a = { fg = c.fg, bg = c.bg }, b = { fg = c.comment, bg = c.bg }, c = { fg = c.fg, bg = c.bg } },
                        inactive = { a = { fg = c.comment, bg = c.bg }, b = { fg = c.comment, bg = c.bg }, c = { fg = c.comment, bg = c.bg } },
                    },
                    globalstatus = true,
                    component_separators = '',
                    section_separators = '',
                    disabled_filetypes = { statusline = { 'dashboard', 'oil' } },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { { 'branch', icon = '', color = { fg = c.comment, bg = c.bg } } },
                    lualine_c = { { 'filename', path = 1, color = { fg = c.fg, bg = c.bg }, symbols = { modified = ' +', readonly = ' -' } } },
                    lualine_x = {
                        { lsp_name, color = { fg = c.cyan, bg = c.bg } },
                        { formatter_name, color = { fg = c.comment, bg = c.bg } },
                        { linter_name, color = { fg = c.warning, bg = c.bg } },
                        { 'diagnostics', color = { fg = c.error, bg = c.bg }, symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' } },
                    },
                    lualine_y = {},
                    lualine_z = {},
                },
            }
        end,
    },
}
