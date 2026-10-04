require("mason").setup()

vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>d", function()
	local enabled = vim.diagnostic.config().virtual_text and true or false
	vim.diagnostic.config({ virtual_text = not enabled })
end, { desc = "Toggle inline diagnostics" })

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.enable({
	"lua_ls",
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = function(desc)
			return { buffer = args.buf, desc = desc }
		end

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
		vim.keymap.set("n", "cd", vim.lsp.buf.rename, opts("Rename symbol"))
		vim.keymap.set({ "n", "v" }, "g.", vim.lsp.buf.code_action, opts("Code action"))
	end,
})
