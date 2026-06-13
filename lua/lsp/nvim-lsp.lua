vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

local augroup = vim.api.nvim_create_augroup("UserLSP", { clear = true })

local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = false, -- disable the inline text
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		wrap = true,
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.lsp.config["*"] = { capabilities = require("blink.cmp").get_lsp_capabilities() }
vim.lsp.config(
	"lua_ls",
	{ settings = { Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } } }
)
vim.lsp.config("emmet_ls", {
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
		"php",
	},
})
vim.lsp.config("astro", {
	init_options = {
		typescript = {
			tsdk = (function()
				-- try local project first
				local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
				if vim.fn.isdirectory(local_ts) == 1 then
					return local_ts
				end
				-- fallback to mason
				return vim.fn.expand(
					"~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
				)
			end)(),
		},
	},
})
vim.lsp.config("tailwindcss", {})
vim.lsp.config("cssls", {})
vim.lsp.config("html", {})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("rnix", {})
vim.lsp.config("clangd", {})
vim.lsp.config("csharp_ls", {})
vim.lsp.config("phpactor", {})

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"ts_ls",
	"gopls",
	"rnix",
	"clangd",
	"csharp_ls",
	"emmet_ls",
	"astro",
	"cssls",
	"html",
	"tailwindcss",
	"phpactor",
})
