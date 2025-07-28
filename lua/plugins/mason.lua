return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        lazy = false,
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "lua_ls",
                --"shfmt",
                --"fish_lsp",
            },
        },
    }
}
