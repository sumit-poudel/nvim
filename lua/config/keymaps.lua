-- ============================================================================
-- KEYMAPS
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Wrap-aware movement (keeps j/k natural but respects wrap)
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Page movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up (centered)" })

-- Redo with U (matches Zed)
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Join lines (keep on gJ since J is now move-line-down)
vim.keymap.set("n", "gJ", "mzJ`z", { desc = "Join lines" })

-- Delete / paste without yanking
vim.keymap.set({ "n", "v" }, "<leader>bx", '"_d', { desc = "Delete (no yank)" })
vim.keymap.set("x", "<leader>ep", '"_dP', { desc = "Paste (no yank)" })

-- ============================================================================
-- LINE MOVEMENT  (Zed: shift-j / shift-k  →  move line down / up)
-- ============================================================================
vim.keymap.set("n", "<S-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<S-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<C-,>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-.>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Duplicate line down (Zed: ctrl-j — conflicts with window nav so use <leader>D)
vim.keymap.set("n", "<leader>D", "yyp", { desc = "Duplicate line down" })

-- Indent in visual
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- ============================================================================
-- WINDOW NAVIGATION  (Ctrl + hjkl)
-- ============================================================================
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Window resize
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Window split  (Zed: space [ / space ])
vim.keymap.set("n", "<leader>[", ":vsplit<CR>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>]", ":split<CR>", { desc = "Split horizontal" })

-- ============================================================================
-- BUFFER  (b)
-- ============================================================================

-- Prev / next buffer  (Zed: shift-h / shift-l)
vim.keymap.set("n", "<S-H>", ":bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-L>", ":bnext<CR>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>bb", function()
	require("fzf-lua").buffers()
end, { desc = "Buffers" })

-- Close current buffer  (Zed: space w)
vim.keymap.set("n", "<leader>w", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>W", function()
	require("mini.bufremove").delete(0, true)
end, { desc = "Delete buffer (force)" })

-- Close other buffers  (Zed: space i)
vim.keymap.set("n", "<leader>i", function()
	local cur = vim.api.nvim_get_current_buf()
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if b ~= cur and vim.bo[b].buflisted then
			require("mini.bufremove").delete(b, false)
		end
	end
end, { desc = "Close other buffers" })

-- Close all buffers  (Zed: space q a)
vim.keymap.set("n", "<leader>qa", function()
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[b].buflisted then
			require("mini.bufremove").delete(b, false)
		end
	end
end, { desc = "Close all buffers" })

vim.keymap.set("n", "<leader>qq", ":q<CR>", { desc = "Quit" })

-- ============================================================================
-- EXPLORER  (Zed: space e → focus panel  |  space ; → toggle right dock)
-- ============================================================================
vim.keymap.set("n", "<leader>e", ":Neotree reveal focus<CR>", { desc = "Explorer focus" })
vim.keymap.set("n", "<leader>;", ":Neotree show toggle<CR>", { desc = "Explorer toggle" })

-- ============================================================================
-- FILE / FZF  (f / g)
-- ============================================================================

-- File finder  (Zed: space f)
vim.keymap.set("n", "<leader>f", function()
	require("fzf-lua").files()
end, { desc = "Find files" })

-- Live grep  (Zed: space g)
vim.keymap.set("n", "<leader>g", function()
	require("fzf-lua").live_grep()
end, { desc = "Grep" })

-- Command palette  (Zed: space p)
vim.keymap.set("n", "<leader>p", function()
	require("fzf-lua").commands()
end, { desc = "Command palette" })

-- Help tags
vim.keymap.set("n", "<leader>hh", function()
	require("fzf-lua").help_tags()
end, { desc = "Help tags" })

-- Format  (Zed: f f)
vim.keymap.set("n", "ff", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format code" })

-- ============================================================================
-- COMMENTS  (Zed: space c)
-- Requires Comment.nvim or mini.comment — mapped via remap=true so the plugin
-- handles the actual motion; works in normal and visual mode.
-- ============================================================================
vim.keymap.set({ "n", "v" }, "<leader>c", "gcc", { remap = true, desc = "Toggle comment" })

-- ============================================================================
-- SEARCH & REPLACE  (Zed: space r)
-- Puts the word under cursor into a :%s// command ready to complete.
-- ============================================================================
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", { desc = "Replace word under cursor" })

-- ============================================================================
-- OUTLINE  (Zed: space o  — requires aerial.nvim or similar)
-- ============================================================================
vim.keymap.set("n", "<leader>o", function()
	-- aerial.nvim  (swap for :SymbolsOutline if you use that instead)
	require("aerial").toggle()
end, { desc = "Outline toggle" })

-- ============================================================================
-- LSP  (l)
-- ============================================================================
vim.keymap.set("n", "<leader>lg", function()
	require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
end, { desc = "Goto definition" })

vim.keymap.set("n", "<leader>lG", function()
	vim.cmd("vsplit")
	vim.lsp.buf.definition()
end, { desc = "Goto definition (split)" })

vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })

vim.keymap.set("n", "<leader>li", function()
	require("fzf-lua").lsp_implementations()
end, { desc = "Implementations" })

vim.keymap.set("n", "<leader>lt", function()
	require("fzf-lua").lsp_typedefs()
end, { desc = "Type definition" })

vim.keymap.set("n", "<leader>ls", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "Document symbols" })

vim.keymap.set("n", "<leader>lS", function()
	require("fzf-lua").lsp_workspace_symbols()
end, { desc = "Workspace symbols" })

vim.keymap.set("n", "<leader>lo", function()
	vim.lsp.buf.code_action({
		context = { only = { "source.organizeImports" }, diagnostics = {} },
		apply = true,
	})
	vim.defer_fn(function()
		vim.lsp.buf.format()
	end, 50)
end, { desc = "Organize imports" })

vim.keymap.set("n", "<leader>lf", function()
	require("fzf-lua").lsp_references()
end, { desc = "References" })

-- Hover docs  (Zed: space d  — also kept on li for muscle memory)
vim.keymap.set("n", "li", vim.lsp.buf.hover, { desc = "Hover docs" })
vim.keymap.set("n", "<leader>d", vim.lsp.buf.hover, { desc = "Hover docs" })

-- ============================================================================
-- DIAGNOSTICS  (d / space j / space ')
-- ============================================================================
vim.keymap.set("n", "<leader>dd", function()
	vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>dc", function()
	vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Cursor diagnostics" })

-- Next / prev diagnostic  (Zed: space j / space ')
vim.keymap.set("n", "<leader>j", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>'", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

-- Also keep the original longer bindings
vim.keymap.set("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

vim.keymap.set("n", "<leader>dl", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostics list" })

vim.keymap.set("n", "<leader>dx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Document diagnostics" })

vim.keymap.set("n", "<leader>dX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Workspace diagnostics" })

-- ============================================================================
-- GIT  (g)
-- ============================================================================
vim.keymap.set("n", "<leader>gs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })

vim.keymap.set("n", "<leader>gr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

vim.keymap.set("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

vim.keymap.set("n", "<leader>gb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })

vim.keymap.set("n", "<leader>gB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle blame" })

vim.keymap.set("n", "<leader>gd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })

-- ============================================================================
-- TOOLS / TOGGLE  (t)
-- ============================================================================
vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
