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
        numbers           = "ordinal",       -- show buffer numbers
        diagnostics       = "nvim_lsp",      -- show LSP errors in bufferline
        separator_style   = "slant",         -- slant | slope | thick | thin
        tab_size = 21,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            }
        }
    }
})
