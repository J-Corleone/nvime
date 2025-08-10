return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
        { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
    },
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
                },
            },

            -- separator_style = 'slant',
            always_show_bufferline = false,
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
            indicator = {
            },
        },
        highlights = {
            indicator_selected = {
            },
        },
    },

    config = function (_, opts)
        vim.opt.termguicolors = true
        require("bufferline").setup(opts)

        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function ()
                vim.schedule(function ()
                    pcall(nvim_bufferline)
                end)
            end
        })
    end
}
