return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        opts = {
            ---@type false | "classic" | "modern" | "helix"
            preset = "modern",
        },
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {}, -- needed even when using default config

        -- recommended: disable vim's auto-folding
        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event =  { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = 'Next Git hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = 'Previous Git hunk' })

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })

                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = 'Stage selected hunk' })

                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = 'Reset selected hunk' })

                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
                map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
                map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Inline preview hunk' })

                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = 'Blame current line (full)' })

                map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff against index' })

                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end, { desc = 'Diff against last commit' })

                map('n', '<leader>hQ', function()
                    gitsigns.setqflist('all')
                end, { desc = 'Send all hunks to quickfix' })

                map('n', '<leader>hq', gitsigns.setqflist, { desc = 'Send current hunk to quickfix' })

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
                map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Git hunk text object' })
            end,

        },
    },
}
