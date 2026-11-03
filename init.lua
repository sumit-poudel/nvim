-- :MasonInstall lua-language-server marksman bash-language-server gopls taplo rust-analyzer emmet-language-server tailwindcss-language-server templ html-lsp stylua clang-format gofumpt goimports prettier shfmt kdlfmt golangci-lint

require("vim._core.ui2").enable({})

require("options")
require("keymaps")
require("commands")
require("pack")
require("treesitter")
require("lsp")

local ok, matugen = pcall(require, "matugen")
if ok then
	matugen.setup()
end

local ok, matugen = pcall(require, 'matugen')
if ok then matugen.setup() end
