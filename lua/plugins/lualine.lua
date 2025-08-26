return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,

	opts = function()
		vim.opt.laststatus = 3
		local opts = {
			options = {
				theme = "catppuccin",
				-- display at most bottom line.(usually in the 2nd line from bottom)
				globalstatus = true,
				disabled_filetypes = {
					statusline = {
						"dashboard",
						"snacks_dashboard",
					},
				},

				always_divide_middle = false,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},

            -- stylua: ignore
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "diagnostics" },
				lualine_x = { "encoding", "filetype" },
				lualine_y = {
					"fileformat",
                    "lsp_status",
				},
				lualine_z = {
					{ "progress", separator = " ", padding = { left = 0, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
			},
		}

		local flavour = require("catppuccin.palettes").get_palette("macchiato")
		local function show_macro_recording()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			else
				return "󰑋 " .. recording_register
			end
		end

		local macro_recording = {
			show_macro_recording,
			color = { fg = "#333333", bg = flavour.red },
			separator = { left = "", right = "" },
			padding = 0,
		}
		table.insert(opts.sections.lualine_x, 1, macro_recording)

		return opts
	end,

	-- config = function (_, opts)
	--     require("lualine").setup(opts)
	-- end
}
