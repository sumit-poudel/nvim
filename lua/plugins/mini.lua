vim.pack.add({
    {
        src = "https://github.com/nvim-mini/mini.nvim",
    },
})
require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

local minibuf = require("mini.bufremove")

vim.keymap.set("n", "<leader>bd", function() minibuf.delete(0, false) end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", function() minibuf.delete(0, true) end, { desc = "Delete buffer (force)" })
