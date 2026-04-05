vim.pack.add({
    { src = "https://github.com/Exafunction/windsurf.nvim" },
})
vim.cmd("packadd windsurf.nvim")

require("codeium").setup({
    enable_cmp_source = false,
})
