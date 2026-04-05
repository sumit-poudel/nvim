vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })

local opts = {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "black" },
		javascript = { "eslint_d", "prettierd" },
		javascriptreact = { "eslint_d", "prettierd" },
		typescript = { "eslint_d", "prettierd" },
		typescriptreact = { "eslint_d", "prettierd" },
		json = { "prettierd", "fixjson" },
		jsonc = { "prettierd", "fixjson" },
		css = { "prettierd" },
		scss = { "prettierd" },
		html = { "prettierd" },
		markdown = { "prettierd" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		go = { "gofumpt" },
		vue = { "eslint_d", "prettierd" },
		svelte = { "eslint_d", "prettierd" },
		astro = { "prettierd" },
		cs = { "csharpier" },
		php = { "php_cs_fixer" },
		yaml = { "yamlfix" },
		toml = { "taplo" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
}

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("ConformFormat", { clear = true }),
	callback = function(args)
		local buf = args.buf
		if vim.bo[buf].buftype ~= "" then
			return
		end
		if not vim.bo[buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(buf) == "" then
			return
		end
		require("conform").format({ bufnr = buf, timeout_ms = 2000, async = false })
	end,
})

vim.keymap.set("n", "<leader>ff", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

require("conform").setup(opts)
