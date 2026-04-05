vim.pack.add({
    {
        src = 'https://github.com/akinsho/bufferline.nvim',
        version = "*",
    },
    -- dependencies
    "https://github.com/nvim-tree/nvim-web-devicons",
})
require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers           = "ordinal",
        diagnostics       = "nvim_lsp",
        separator_style   = "slant",
        tab_size = 21,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            }
        },
        close_command = function(buf)
            require("mini.bufremove").delete(buf, false)
        end,
        middle_mouse_command = function(buf)
            require("mini.bufremove").delete(buf, false)
        end,
        right_mouse_command = function(buf)
            require("mini.bufremove").delete(buf, false)
        end,
    }
})
