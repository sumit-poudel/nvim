require("mason").setup()

vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.enable({
	"lua-language-server",
	"marksman",
	"bashls",
	"gopls",
	"taplo",
	"rust_analyzer",
})

require("lint").linters_by_ft = {
	go = { "golangci-lint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
