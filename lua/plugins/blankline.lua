return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        indent = {
            char = "│", -- Standard vertical line
            tab_char = "│",
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            -- This highlights the current indentation level you're working in
            highlight = { "Function", "Label" }, 
        },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree", -- Don't show indent lines in your sidebar
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
            },
        },
    },
}
