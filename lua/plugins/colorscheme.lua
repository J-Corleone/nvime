return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		flavour = "frappe", -- latte, frappe, macchiato, mocha
		opts = {
			transparent_background = true,
			float = {
				transparent = true,
				-- solid = true,
			},
			custom_highlights = function(colors)
				return {
                    -- stylua: ignore
                    LineNr = { fg = colors.surface2 },
					Visual = { bg = colors.overlay0 },
					Search = { bg = colors.surface2 },
					IncSearch = { bg = colors.lavender },
					CurSearch = { bg = colors.lavender },
					MatchParen = { bg = colors.lavender, fg = colors.base, bold = true },

					DapStopped = { fg = "#98c379" }, -- used for nvim-dap (#98c379 best)
				}
			end,
			integrations = {
				-- UI
				treesitter = true,
				neotree = true,
				rainbow_delimiters = true,
				render_markdown = true,
				dap_ui = true,

				-- Cmp and Lsp
				blink_cmp = { style = "bordered" },
				mason = true,
				dap = true,

				-- Qor
				noice = true,
				notify = true,
				snacks = true,
				which_key = true,

				gitsigns = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
