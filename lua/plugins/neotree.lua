return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		cmd = "Neotree",

        -- stylua: ignore
        keys = {
            {
                "<leader>fe",
                function()
                    -- vim.env.PWD - always equals the dir where u open nvim.
                    -- vim.fn.getcwd(-1, -1) - global current dir(will changed with :cd)
                    -- getcwd() - current window dir (changed with :lcd)
                    -- getcwd(-1) - current tab dir (changed with :tcd)
                    require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd(-1, -1) })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            {
                "<leader>fE",
                function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.fn.stdpath('config') })
                end,
                desc = "Explorer NeoTree (nvim config dir)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (nvim config dir)", remap = true },
            {
                "<leader>ge",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git Explorer",
            },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer Explorer",
            },
        },
		opts = {
			window = {
				width = 30,
			},
		},
	},
}
