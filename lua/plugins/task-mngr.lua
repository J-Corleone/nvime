return {
	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },

        -- stylua: ignore
		keys = {
			{
                "<F6>", "<cmd>CompilerOpen<cr>",
                desc = "Open compiler (compiler)",
                noremap = true, silent = true
            },
			{
				"<leader>cr",
				"<cmd>CompilerStop<cr>" -- Optional, to dispose all tasks before redo
                .. "<cmd>CompilerRedo<cr>",
				desc = "Redo last selected option (compiler)",
				noremap = true, silent = true,
			},
			{
                "<leader>ct", "<cmd>CompilerToggleResults<cr>",
                desc = "Toggle compiler results (compiler)",
                noremap = true, silent = true
            },
		},
		opts = {},
	},
	{
		-- The task runner compiler.nvim use
		"stevearc/overseer.nvim",
		-- commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 15,
				max_height = 15,
				default_detail = 1,
			},
			-- disable overseer's notifications.
			component_aliases = {
				default = {
					{ "display_duration", detail_level = 2 },
					"on_output_summarize",
					"on_exit_set_status",
					--"on_complete_notify",
					"on_complete_dispose",
				},
			},
		},
	},
}
