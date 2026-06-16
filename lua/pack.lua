vim.pack.add({
	"https://github.com/RRethy/base16-nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim.git",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/stevearc/aerial.nvim",
})

-- mini files ----
local MiniFiles = require("mini.files")
MiniFiles.setup({
	mappings = {
		go_in = "<CR>",
		go_in_plus = "L",
		go_out = "_",
		go_out_plus = "H",
		synchronize = "s",
	},
})

vim.keymap.set("n", ";", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>e", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

---- mini tabline ----
require("mini.tabline").setup()

---- mini statusline----
require("mini.statusline").setup()

vim.keymap.set("n", "H", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "L", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>w", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>i", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_valid(buf) then
			require("mini.bufremove").delete(buf, false)
		end
	end
end, { desc = "Delete all buffers except current" })

---- mini notify ----
require("mini.notify").setup({
	-- only show messages
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
})

--- mini cmdline completion ---
require("mini.cmdline").setup({
	autocorrect = { enable = false },
})
require("mini.pairs").setup()

--- mini surround ---
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

--- mini picker ---
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

-- keymaps
vim.keymap.set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>fg", function()
	MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Grep word/Search word" })
vim.keymap.set("n", "<leader>hh", function()
	MiniPick.builtin.help()
end, { desc = "Mini Help" })

vim.keymap.set("n", "<leader>d", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>j", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>'", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>pk", function()
	MiniExtra.pickers.keymaps()
end, { desc = "Search keymaps" })

--- mini completions ---
require("mini.completion").setup({
	lsp_completion = {
		auto_setup = true,
	},
})

--- mini snippets ---
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
	snippets = {
		MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
	},
})
MiniSnippets.start_lsp_server({ match = false })

--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }),
})

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive Full Page New Tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split" })

--- conform ---
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofumpt", "goimports" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		kdl = { "kdlfmt" },
		toml = { "taplo" },
	},
})

vim.keymap.set("n", "ff", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

--- aerial ---
require("aerial").setup()
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle aerial outline" })
