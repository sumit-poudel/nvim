require("config.init")
require("plugins.init")
require("lsp.init")

local ok, matugen = pcall(require, "matugen")
if ok then
	matugen.setup()
end

local ok, matugen = pcall(require, "matugen")
if ok then
	matugen.setup()
end
