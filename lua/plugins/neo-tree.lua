vim.pack.add({
    {
        src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
        version = vim.version.range('3')
    },
    -- dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    -- optional, but recommended
    "https://github.com/nvim-tree/nvim-web-devicons",
})

require('neo-tree').setup({
    source_selector = {
        winbar = true,
        statusline = false
    },
    close_if_last_window = true, -- Close Neo-tree if it's the last window left
    window = {
        position = "left",
        width = 30,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<cr>"] = "open",
            ["w"] = "open_with_window_picker", -- Matches your current workflow
            ["s"] = "split_with_window_picker",
            ["v"] = "vsplit_with_window_picker",
            ["z"] = "close_node",
            ["a"] = "add", -- Adds a file or directory
            ["d"] = "delete",
            ["r"] = "rename",
        },
    },
    filesystem = {
        filtered_items = {
            visible = false, 
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = {
                "node_modules",
                ".git",
            },
        },
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the tree
        },
        use_libuv_file_watcher = true, -- Automatically updates the tree on file changes
    },
    default_component_configs = {
        indent = {
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
        },
        git_status = {
            symbols = {
                added    = "✚",
                modified = "",
                deleted  = "✖",
                renamed  = "󰁯",
                untracked = "",
                ignored  = "",
                unstaged = "󰄱",
                staged   = "",
                conflict = "",
            },
        },
    },
})
