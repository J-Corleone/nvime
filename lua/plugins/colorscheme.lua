return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        opts = {
            transparent_background = true,
            custom_highlights = function (colors)
                return {
                    LineNr = { fg = colors.surface2 },
                    Visual = { bg = colors.overlay0 },
                    Search = { bg = colors.surface2 },
                    IncSearch = { bg = colors.lavender },
                    CurSearch = { bg = colors.lavender },
                    MatchParen = { bg = colors.lavender, fg = colors.base, bold = true },
                }
            end,
            integrations = {
                -- UI
                neotree = true,
                -- telescope = true,
                rainbow_delimiters = true,

                -- Cmp and Lsp
                treesitter = true,
                blink_cmp = { style = 'bordered', },
                mason = true,

                -- Qor
                noice = true,
                notify = true,
                -- snacks = true,
                -- which_key = true,

                -- gitsigns = true,
            },
        },
        config = function (_, opts)
            require("catppuccin").setup(opts)

            vim.cmd.colorscheme("catppuccin")
        end
    },
}
