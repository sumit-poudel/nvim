return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },

        init = function()
            vim.api.nvim_create_autocmd("TabEnter", {
                callback = function()
                    require("neo-tree.command").execute({
                        action   = "show",
                        source   = "filesystem",
                        position = "left",
                    })
                end,
            })
        end,

        opts = {
            close_if_last_window = false,
            popup_border_style   = "rounded",
            enable_git_status    = true,
            enable_diagnostics   = true,

            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },

            filesystem = {
                filtered_items = {
                    visible         = false,
                    hide_dotfiles   = false,
                    hide_gitignored = true,
                    hide_hidden     = false,
                },
                follow_current_file    = { enabled = true },
                use_libuv_file_watcher = true,
                hijack_netrw_behavior  = "open_current",
            },

            window = {
                position = "left",
                width    = 30,
                mapping_options = { noremap = true, nowait = true },
                mappings = {
                    ["<space>"] = "none",

                    -- Open in last active window
                    ["<cr>"]    = "open_with_window_picker",
                    ["l"]       = "open_with_window_picker",

                    -- Open in new buffer
                    ["e"] = function(state)
                        local node = state.tree:get_node()
                        if node.type ~= "directory" then
                            vim.cmd("enew")
                            vim.cmd("edit " .. vim.fn.fnameescape(node.path))
                        end
                    end,

                    -- Open in splits
                    ["S"]       = "open_split",
                    ["s"]       = "open_vsplit",
                    ["t"]       = "open_tabnew",
                    ["w"]       = "open_with_window_picker",

                    -- Navigation
                    ["h"]       = "close_node",
                    ["H"]       = "toggle_hidden",
                    ["<"]       = "navigate_up",
                    [">"]       = "set_root",
                    ["/"]       = "fuzzy_finder",

                    -- Node operations
                    ["C"]       = "close_node",
                    ["z"]       = "close_all_nodes",
                    ["Z"]       = "expand_all_nodes",

                    -- File operations
                    ["a"]       = { "add", config = { show_path = "none" } },
                    ["A"]       = "add_directory",
                    ["d"]       = "delete",
                    ["r"]       = "rename",
                    ["y"]       = "copy_to_clipboard",
                    ["x"]       = "cut_to_clipboard",
                    ["p"]       = "paste_from_clipboard",
                    ["c"]       = "copy",
                    ["m"]       = "move",

                    -- Misc
                    ["R"]       = "refresh",
                    ["q"]       = "close_window",
                    ["?"]       = "show_help",
                },
            },

            default_component_configs = {
                indent = {
                    with_markers       = true,
                    indent_marker      = "│",
                    last_indent_marker = "└",
                    indent_size        = 2,
                },
                modified = {
                    symbol    = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash        = false,
                    use_git_status_colors = true,
                    highlight             = "NeoTreeFileName",
                },
                icon = {
                    folder_closed = "",
                    folder_open   = "",
                    folder_empty  = "󰜌",
                    default       = "*",
                    highlight     = "NeoTreeFileIcon",
                },
                git_status = {
                    symbols = {
                        added     = "✚",
                        modified  = "",
                        deleted   = "✖",
                        renamed   = "󰁯",
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    },
                },
            },

            buffers = {
                follow_current_file = { enabled = true },
                group_empty_dirs    = true,
                show_unloaded       = true,
            },

            git_status = {
                window = {
                    position = "float",
                },
            },
        },
    },

    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },

    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one      = true,
                    bo = {
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        buftype  = { "terminal", "quickfix" },
                    },
                },
            })
        end,
    },
}
