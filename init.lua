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
