vim.g.mapleader = " "

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set({ "n", "v" }, "<leader>dd", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yanking" })

vim.keymap.set("n", "<leader>c", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("v", "<leader>c", "gc", { desc = "Toggle comment", remap = true })

vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

vim.keymap.set("n", "<Esc>", function()
	vim.cmd("nohl")
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if
			vim.api.nvim_win_get_config(win).relative ~= ""
			and vim.bo[buf].buftype ~= "terminal"
			and not vim.bo[buf].filetype:match("^minifiles")
		then
			pcall(vim.api.nvim_win_close, win, false)
		end
	end
end, { desc = "Clear search highlight and close floats", silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<C-[>", "zc", { desc = "Fold" })
vim.keymap.set("n", "<C-]>", "zo", { desc = "Unfold" })
vim.keymap.set("n", "<C-M-[>", "zM", { desc = "Fold all" })
vim.keymap.set("n", "<C-M-]>", "zR", { desc = "Unfold all" })

vim.keymap.set(
	"n",
	"<leader>r",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- split
vim.keymap.set("n", "<leader>-", "<cmd>new<CR>", { desc = "New file split below" })
vim.keymap.set("n", "<leader>|", "<cmd>vnew<CR>", { desc = "New file split right" })
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Go to left split" })
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Go to right split" })
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Go to upper split" })
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Go to lower split" })


-- native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
