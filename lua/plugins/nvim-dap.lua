return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

		dependencies = {
			"rcarriga/nvim-dap-ui",
			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
        --stylua: ignore
		keys = {
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition", },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue", },
			{ "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args", },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
			{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)", },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
			{ "<leader>dj", function() require("dap").down() end, desc = "Down", },
			{ "<leader>dk", function() require("dap").up() end, desc = "Up", },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last", },
			{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out", },
			{ "<leader>dO", function() require("dap").step_over() end, desc = "Step Over", },
			{ "<leader>dP", function() require("dap").pause() end, desc = "Pause", },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
			{ "<leader>ds", function() require("dap").session() end, desc = "Session", },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate", },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets", },
		},

		opts = function()
			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "executable",
				command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

				-- On windows you may have to uncomment this:
				-- detached = false,
			}
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
			}
			dap.configurations.cpp = {
				{
					name = "Launch file (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Attach to process (codelldb)",
					type = "codelldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Launch file (gdb)",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,

					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
						-- { text = "set follow-fork-mode child", description = "Follow child process after fork", ignoreFailures = false },
						{
							text = "set detach-on-fork off",
							description = "Do not detach other process",
							ignoreFailures = false,
						},
						{
							text = "set breakpoint pending on",
							description = "allow breakpoints before symbols loaded",
							ignoreFailures = false,
						},
						-- { text = "catch exec", description="stop when exec happens", ignoreFailures = false },
					},
				},
				{
					name = "Attach to process (gdb)",
					type = "cppdbg",
					request = "attach",
					MIMode = "gdb",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",

					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,

					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
		end,

		init = function()
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            -- stylua: ignore
			local dap_breakpoint = {
				breakpos = {
                    text = "⬤",
					texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint",
				},
				condition = {
					text = "",
					texthl = "DapBreakpointCondition",
                    linehl = "DapBreakpointCondition", numhl = "DapBreakpointCondition",
				},
				rejected = {
					text = "",
					texthl = "DapBreakpointRejected",
                    linehl = "DapBreakpointRejected", numhl = "DapBreakpointRejected",
				},
				logpoint = {
					text = "",
					texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint",
				},
				stopped = {
					text = "➤",
					texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped",
				},
			}
			vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpos)
			vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
			vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
			vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
			vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
		end,

		config = function()
			-- load mason-nvim-dap here, after all adapters have been setup
			-- require("mason-nvim-dap").setup()

			-- setup dap config by VsCode launch.json file
			-- local vscode = require("dap.ext.vscode")
			-- local json = require("plenary.json")
			-- vscode.json_decode = function(str)
			--     return vim.json.decode(json.json_strip_comments(str))
			-- end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },

        -- stylua: ignore
		keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" }, },
		},

		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = "mason.nvim",
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			-- only install those u have been configured.
			automatic_installation = true,
			ensure_installed = {},

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},
		},
		-- mason-nvim-dap is loaded when nvim-dap loads
		config = function() end,
	},
}
