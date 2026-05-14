return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        lazy = true,
        event = 'InsertEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'archie-judd/blink-cmp-words',
        },
        opts = {
            keymap = { preset = 'default' },
            completion = {
                ghost_text = { enabled = true },
                menu = {
                    border = 'rounded',
                    draw = {
                        columns = {
                            { 'kind_icon', 'kind', gap = 2 },
                            { 'label', 'label_description' },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    window = { border = 'rounded' },
                },
            },
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    thesaurus = {
                        name = 'blink-cmp-words',
                        module = 'blink-cmp-words.thesaurus',
                        opts = {
                            score_offset = 0,
                            definition_pointers = { '!', '&', '^' },
                            similarity_pointers = { '&', '^' },
                            similarity_depth = 2,
                        },
                    },
                    dictionary = {
                        name = 'blink-cmp-words',
                        module = 'blink-cmp-words.dictionary',
                        opts = {
                            dictionary_search_threshold = 3,
                            score_offset = 0,
                            definition_pointers = { '!', '&', '^' },
                        },
                    },
                },
                per_filetype = {
                    text     = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary' },
                    markdown = { 'lsp', 'path', 'snippets', 'buffer', 'thesaurus' },
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'ruff_format' },
                    sh = { 'shfmt' },
                    c = { 'c_formatter_42' },
                },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'nvim-mini/mini.surround',
        version = '*',
        config = function()
            require('mini.surround').setup()
        end,
    },
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({})
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        opts = {},
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufEnter',
        config = true,
    },
}
