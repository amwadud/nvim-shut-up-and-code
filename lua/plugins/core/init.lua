return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts = require('nvim-treesitter')
            local parsers = {
                'bash', 'comment', 'css', 'diff', 'dockerfile',
                'elixir', 'git_config', 'gitcommit', 'gitignore',
                'groovy', 'go', 'heex', 'hcl', 'html', 'http',
                'java', 'javascript', 'jsdoc', 'json', 'json5',
                'lua', 'make', 'markdown', 'markdown_inline',
                'python', 'regex', 'rst', 'rust', 'scss',
                'ssh_config', 'sql', 'terraform', 'typst',
                'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
            }

            for _, parser in ipairs(parsers) do
                ts.install(parser)
            end

            local patterns = {}
            for _, parser in ipairs(parsers) do
                local parser_patterns = vim.treesitter.language.get_filetypes(parser)
                for _, pp in pairs(parser_patterns) do
                    table.insert(patterns, pp)
                end
            end

            vim.treesitter.language.register('groovy', 'Jenkinsfile')
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'

            vim.api.nvim_create_autocmd('FileType', {
                pattern = patterns,
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require('ufo').setup({
                provider_selector = function()
                    return { 'treesitter', 'indent' }
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'VeryLazy',
        config = function()
            require('treesitter-context').setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = 'outer',
                mode = 'cursor',
                separator = nil,
                zindex = 20,
                on_attach = nil,
            })
        end,
    },
}
