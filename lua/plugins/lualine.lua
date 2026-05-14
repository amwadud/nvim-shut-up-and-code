-- ============================================================
-- lualine.lua — minimal, unified bg, always-visible toolchain
-- Philosophy:
--   • One bg color everywhere (Normal bg)
--   • Toolchain slots always visible: active = colored, inactive = dimmed
--   • Left: where you are | Right: what's running / broken
-- ============================================================

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

-- ── Theme: flat, one bg everywhere ──────────────────────────
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

-- ── Path ────────────────────────────────────────────────────
local function filepath()
    local rel = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~:.')
    if rel == '' then
        return '[No Name]'
    end
    return rel
end

local function filepath_color()
    local c = get_colors()
    if vim.fn.expand('%:t') == '' then
        return { fg = c.warning, bg = c.bg }
    end
    if vim.bo.modified then
        return { fg = c.warning, bg = c.bg }
    end
    return { fg = c.fg, bg = c.bg }
end

-- ── LSP ─────────────────────────────────────────────────────
local function lsp_component()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return '󰒋 none'
    end
    return '󰒋 '
        .. table.concat(
            vim.tbl_map(function(c)
                return c.name
            end, clients),
            ', '
        )
end

local function lsp_color()
    local c = get_colors()
    return { fg = #vim.lsp.get_clients({ bufnr = 0 }) == 0 and c.comment or c.cyan, bg = c.bg }
end

-- ── Formatter ───────────────────────────────────────────────
local function formatter_component()
    local ok, conform = pcall(require, 'conform')
    local formatters = ok and conform.list_formatters(0) or {}
    if #formatters == 0 then
        return '󰉿 none'
    end
    return '󰉿 '
        .. table.concat(
            vim.ttml_map(function(f)
                return f.name
            end, formatters),
            ', '
        )
end

local function formatter_color()
    local c = get_colors()
    local ok, conform = pcall(require, 'conform')
    local formatters = ok and conform.list_formatters(0) or {}
    return { fg = #formatters == 0 and c.comment or c.fg, bg = c.bg }
end

-- ── Linter ──────────────────────────────────────────────────
local function linter_component()
    local ok, lint = pcall(require, 'lint')
    local linters = ok and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
    if #linters == 0 then
        return '󱉶 none'
    end
    return '󱉶 ' .. table.concat(linters, ', ')
end

local function linter_color()
    local c = get_colors()
    local ok, lint = pcall(require, 'lint')
    local linters = ok and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
    return { fg = #linters == 0 and c.comment or c.warning, bg = c.bg }
end

-- ── Extras ──────────────────────────────────────────────────

-- Shows buffer count when >1 open — disappears when solo
local function buffer_count()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs <= 1 then
        return ''
    end
    return '󰓩 ' .. #bufs
end

-- Shows active macro recording — easy to forget you're in one
local function macro_recording()
    local reg = vim.fn.reg_recording()
    if reg == '' then
        return ''
    end
    return '󰑊 @' .. reg
end

-- ── Assembly ─────────────────────────────────────────────────
return {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        return {
            options = {
                theme = get_theme,
                globalstatus = true,
                component_separators = '',
                section_separators = '',
                -- disabled_filetypes = { statusline = { 'oil', 'dashboard', '' } },
                disabled_filetypes = { 'dashboard', 'oil', '' },
            },
            sections = {
                -- LEFT: where you are
                lualine_a = {},
                lualine_b = { { 'branch', icon = ' ', color = col('comment') } },
                lualine_c = {
                    { filepath, icon = '󰈔 ', color = filepath_color },
                    { macro_recording, color = col('warning') },
                },

                -- RIGHT: toolchain health
                lualine_x = {
                    {
                        'diagnostics',
                        symbols = { error = '󰅙 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' },
                    },
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
}
