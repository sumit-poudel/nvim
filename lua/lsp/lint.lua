vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint" } })

local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    python = { "ruff" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    json = { "eslint_d" },
    jsonc = { "eslint_d" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "shellcheck" },
    c = { "cpplint" },
    cpp = { "cpplint" },
    go = { "revive" },
    php = { "phpcs" },
    css = { "stylelint" },
    scss = { "stylelint" },
    yaml = { "yamllint" },
    markdown = { "markdownlint" },
    vue = { "eslint_d" },
    svelte = { "eslint_d" },
    astro = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("Lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})
