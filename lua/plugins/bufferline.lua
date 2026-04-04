return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        opts = {
            options = {
                mode              = "buffers",       -- show buffers (not tabs)
                numbers           = "ordinal",       -- show buffer numbers
                diagnostics       = "nvim_lsp",      -- show LSP errors in bufferline
                separator_style   = "slant",         -- slant | slope | thick | thin
                always_show_bufferline = true,
                show_buffer_close_icons = true,
                show_close_icon         = false,
                color_icons             = true,
                enforce_regular_tabs    = false,
                max_name_length         = 20,
                tab_size                = 21,

                -- Offset for neo-tree so bufferline doesn't overlap it
                offsets = {
                    {
                        filetype   = "neo-tree",
                        text       = "  File Explorer",
                        highlight  = "Directory",
                        text_align = "left",
                        separator  = true,
                    },
                },

                -- Close buffer properly (goes to prev buffer instead of closing window)
                close_command = function(n)
                    require("mini.bufremove").delete(n, false)
                end,
                right_mouse_command = function(n)
                    require("mini.bufremove").delete(n, false)
                end,

                -- Don't show these in the bufferline
                custom_filter = function(buf_number)
                    local ft = vim.bo[buf_number].filetype
                    local name = vim.api.nvim_buf_get_name(buf_number)
                    if ft == "neo-tree" then return false end
                    if ft == "qf" then return false end
                    if name == "" then return false end
                    return true
                end,
            },
        },
    },
}
