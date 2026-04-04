local set = vim.keymap.set
local builtin = require('telescope.builtin')

-- ─── Window Navigation ────────────────────────────────────────────────────────
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right window" })

-- ─── Window Resizing ──────────────────────────────────────────────────────────
set("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
set("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
set("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ─── Window Splits ────────────────────────────────────────────────────────────
set("n", "<leader>s", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
set("n", "<leader>S", "<cmd>split<CR>",  { desc = "Split window horizontally" })
set("n", "<leader>wq", "<cmd>close<CR>",  { desc = "Close window" })
set("n", "<leader>wo", "<cmd>only<CR>",   { desc = "Close all other windows" })

-- ─── Buffer Switching (skips neo-tree) ────────────────────────────────────────
local function buf_switch(cmd)
    return function()
        if vim.bo.filetype == "neo-tree" then
            vim.cmd("wincmd p")
        end
        vim.cmd(cmd)
    end
end

set("n", "<Tab>",        buf_switch("bnext"),     { noremap = true, silent = true, desc = "Next buffer" })
set("n", "<S-Tab>",      buf_switch("bprevious"), { noremap = true, silent = true, desc = "Prev buffer" })
set("n", "<leader>bd",   "<cmd>bd<CR>",           { desc = "Delete buffer" })
set("n", "<leader>bD",   "<cmd>bd!<CR>",          { desc = "Delete buffer (force)" })
set("n", "<leader>bn",   "<cmd>enew<CR>",         { desc = "New buffer" })
set("n", "<leader>ba",   "<cmd>%bd|e#<CR>",       { desc = "Delete all buffers except current" })

-- ─── Neo-tree ─────────────────────────────────────────────────────────────────
set("n", "<leader>e", function()
    require("neo-tree.command").execute({
        toggle   = true,
        source   = "filesystem",
        position = "left",
    })
end, { noremap = true, silent = true, desc = "Toggle Neo-tree" })

-- ─── Search ───────────────────────────────────────────────────────────────────
set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- ─── Line Movement ────────────────────────────────────────────────────────────
set("n", "<A-j>", "<cmd>m .+1<CR>==",        { desc = "Move line down" })
set("n", "<A-k>", "<cmd>m .-2<CR>==",        { desc = "Move line up" })
set("v", "<A-j>", ":m '>+1<CR>gv=gv",        { desc = "Move selection down" })
set("v", "<A-k>", ":m '<-2<CR>gv=gv",        { desc = "Move selection up" })

-- ─── Indenting (stay in visual mode) ─────────────────────────────────────────
set("v", "<", "<gv", { desc = "Indent left" })
set("v", ">", ">gv", { desc = "Indent right" })

-- ─── Better paste (don't yank on paste in visual) ────────────────────────────
set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- ─── Save ─────────────────────────────────────────────────────────────────────
set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- ─── Quit ─────────────────────────────────────────────────────────────────────
set("n", "<leader>qq", "<cmd>qa<CR>",  { desc = "Quit all" })
set("n", "<leader>wq", "<cmd>wqa<CR>", { desc = "Save and quit all" })

-- ─── Help ─────────────────────────────────────────────────────────────────────
set("n", "<leader>hc", "<cmd>helpclose<CR>", { desc = "Close help" })
set("n", "<leader>hh", ":help ",             { desc = "Open help" })

-- ─── LSP ──────────────────────────────────────────────────────────────────────
set("n", "<leader>cf", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer [LSP]" })

-- ─── Clipboard ────────────────────────────────────────────────────────────────
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
set({ "n", "v" }, "<leader>P", '"+p', { desc = "Paste from system clipboard" })

-- ─── Misc ─────────────────────────────────────────────────────────────────────
set("n", "<leader>un", "<cmd>noh<CR>",                   { desc = "Clear search highlight" })
set("n", "<leader>uw", "<cmd>set wrap!<CR>",             { desc = "Toggle word wrap" })
set("n", "<leader>ul", "<cmd>set relativenumber!<CR>",   { desc = "Toggle relative line numbers" })
set("n", "<leader>us", "<cmd>set spell!<CR>",            { desc = "Toggle spell check" })

-- ─── Telescope ─────────────────────────────────────────────────────────────────────
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


