vim.pack.add({
	{
		src = "https://github.com/RRethy/base16-nvim",
		version = "*",
	},
})
return {
	config = function()
		local ok, matugen = pcall(require, "matugen")
		if ok then
			matugen.setup()
		end
	end,
}
