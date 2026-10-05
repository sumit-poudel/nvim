vim.pack.add({
	"https://github.com/RRethy/base16-nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/stevearc/aerial.nvim",
	"https://github.com/brenton-leighton/multiple-cursors.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/hyperpuncher/datastar-lsp",
	"https://github.com/hyperpuncher/tree-sitter-datastar",
})

local map = vim.keymap.set

--- mini icons ---
local MiniIcons = require("mini.icons")
MiniIcons.setup()
MiniIcons.mock_nvim_web_devicons()

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

map("n", ";", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
map("n", "<leader>e", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

-- setup toggleterm
require("toggleterm").setup({
	direction = "vertical",
	size = 80,
	persist_size = true,
	persist_mode = true,
	shade_terminals = false,
})

local Terminal = require("toggleterm.terminal").Terminal
local tmux_terms = {}

local function toggle_tmux()
	local cwd = vim.fn.getcwd()
	if not tmux_terms[cwd] then
		local name = vim.fs.basename(cwd):gsub("[.:]", "-")
		tmux_terms[cwd] = Terminal:new({
			cmd = "tmux new-session -A -s " .. vim.fn.shellescape(name),
			direction = "vertical",
			hidden = true,
			close_on_exit = true,
		})
	end
	tmux_terms[cwd]:toggle()
end
map({ "n", "t" }, "<c-/>", toggle_tmux, { desc = "Toggle tmux terminal" })

---- mini tabline ----
require("mini.tabline").setup({
	format = function(buf_id, label)
		local icon = MiniIcons.get("file", label)
		local suffix = vim.bo[buf_id].modified and " *" or ""
		return " " .. icon .. " " .. label .. suffix .. " "
	end,
})

---- mini statusline----
require("mini.statusline").setup()

map("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "H", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map("n", "<leader>w", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })
map("n", "<leader>i", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_valid(buf) then
			require("mini.bufremove").delete(buf, false)
		end
	end
end, { desc = "Delete all buffers except current" })

---- mini notify ----
require("mini.notify").setup({
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

--- mini ai ---
local MiniAi = require("mini.ai")
MiniAi.setup({
	custom_textobjects = {
		f = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		c = MiniAi.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
		s = MiniAi.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
		F = MiniAi.gen_spec.function_call(), -- old mini.ai `f` (call), optional
	},
})

--- mini picker ---
local MiniPick = require("mini.pick")
MiniPick.setup()
vim.ui.select = MiniPick.ui_select
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>hh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })
map("n", "<leader>pk", builtin.keymaps, { desc = "keymaps" })
map("n", "<leader>j", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<leader>'", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

--- mini completions ---
require("mini.completion").setup({
	lsp_completion = {
		auto_setup = true,
	},
	fallback_action = "<C-x><C-f>",
})

--- mini snippets ---
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
	snippets = {
		MiniSnippets.gen_loader.from_lang(),
	},
	mappings = {
		stop = "<c-k>",
	},
	expand = {
		trigger = "", -- No automatic trigger
	},
})
MiniSnippets.start_lsp_server({ match = false })

--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }),
	mappings = {
		apply = "", -- frees gh for LSP hover
	},
})

map("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive Full Page New Tab" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split" })

--- conform ---
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		go = { "gofumpt", "goimports" },
		javascript = { "prettier" },
		sh = { "shfmt" },
		typescript = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		kdl = { "kdlfmt" },
		toml = { "taplo" },
		templ = { "templ" },
	},
})

map("n", "ff", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

--- lines ---
require("ibl").setup()

--- aerial ---
require("aerial").setup()
map("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle aerial outline" })

-- multi cursor ---
require("multiple-cursors").setup({})
map({ "n", "x" }, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })
map({ "n", "x" }, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })
map({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })
map({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })
map(
	{ "n", "i" },
	"<C-LeftMouse>",
	"<Cmd>MultipleCursorsMouseAddDelete<CR>",
	{ desc = "Add or remove cursor on mouse click" }
)
map(
	{ "n" },
	"<C-Return>",
	"<Cmd>MultipleCursorsAddDelete<CR>",
	{ desc = "Add a locked cursor or remove an existing cursor" }
)
