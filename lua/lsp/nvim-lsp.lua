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
    virtual_text = { prefix = "●", spacing = 4 },
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
    if not client then return end

    local bufnr = ev.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<leader>gd", function() require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end, { desc = "Goto definition (fzf)", unpack(opts) })
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, { desc = "Goto definition", unpack(opts) })
    vim.keymap.set("n", "<leader>gS", function() vim.cmd("vsplit") vim.lsp.buf.definition() end, { desc = "Goto definition in split", unpack(opts) })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", unpack(opts) })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", unpack(opts) })
    vim.keymap.set("n", "<leader>D", function() vim.diagnostic.open_float({ scope = "line" }) end, { desc = "Line diagnostics", unpack(opts) })
    vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float({ scope = "cursor" }) end, { desc = "Cursor diagnostics", unpack(opts) })
    vim.keymap.set("n", "<leader>nd", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic", unpack(opts) })
    vim.keymap.set("n", "<leader>pd", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic", unpack(opts) })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation", unpack(opts) })
    vim.keymap.set("n", "<leader>fd", function() require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end, { desc = "FZF definitions", unpack(opts) })
    vim.keymap.set("n", "<leader>fr", function() require("fzf-lua").lsp_references() end, { desc = "FZF references", unpack(opts) })
    vim.keymap.set("n", "<leader>ft", function() require("fzf-lua").lsp_typedefs() end, { desc = "FZF type definitions", unpack(opts) })
    vim.keymap.set("n", "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, { desc = "FZF document symbols", unpack(opts) })
    vim.keymap.set("n", "<leader>fw", function() require("fzf-lua").lsp_workspace_symbols() end, { desc = "FZF workspace symbols", unpack(opts) })
    vim.keymap.set("n", "<leader>fi", function() require("fzf-lua").lsp_implementations() end, { desc = "FZF implementations", unpack(opts) })

    if client:supports_method("textDocument/codeAction", bufnr) then
        vim.keymap.set("n", "<leader>oi", function()
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} }, apply = true, bufnr = bufnr })
            vim.defer_fn(function() vim.lsp.buf.format({ bufnr = bufnr }) end, 50)
        end, { desc = "Organize imports", unpack(opts) })
    end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function() vim.diagnostic.setloclist({ open = true }) end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.lsp.config["*"] = { capabilities = require("blink.cmp").get_lsp_capabilities() }
vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } } })
vim.lsp.config("emmet_ls", {
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
})
vim.lsp.config("astro", {})
vim.lsp.config("cssls", {})
vim.lsp.config("html", {})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

vim.lsp.enable({
    "lua_ls", "pyright", "bashls", "ts_ls", "gopls", "clangd", "efm",
    "emmet_ls", "astro", "cssls", "html",
})
