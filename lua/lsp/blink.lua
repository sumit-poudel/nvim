vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*"),
    },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
})
vim.cmd("packadd blink.cmp")
vim.cmd("packadd friendly-snippets")

require("blink.cmp").setup({
    keymap = {
        preset = "none",
        ["<C-Space>"] = { "show", "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-f>"] = { "snippet_forward", "fallback" },
        ["<C-b>"] = { "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = { 
        menu = { auto_show = true },
        trigger = { show_on_trigger_character = true },
    },
    sources = {
        default = { "snippets", "lsp", "path", "buffer", "codeium" },
        providers = {
            lsp = {
                score_offset = 100,
            },
            snippets = {
                opts = {
                    friendly_snippets = true,
                },
            },
            codeium = { name = "Codeium", module = "codeium.blink", async = true },
        },
    },
    fuzzy = {
        implementation = "prefer_rust",
        prebuilt_binaries = { download = true },
    },
})
