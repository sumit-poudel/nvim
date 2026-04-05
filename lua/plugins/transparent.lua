vim.pack.add({
	{
		src = "https://github.com/xiyaowong/transparent.nvim",
	},
})

require("transparent").setup({
	groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"EndOfBuffer",
	},
	extra_groups = {
		"NormalFloat",
		"FloatBorder",
		"NeoTreeNormal",
		"NeoTreeNormalNC",
		"NeoTreeEndOfBuffer",
		"TelescopeNormal",
		"TelescopeBorder",
		"LazyNormal",
		"MasonNormal",
		"Pmenu",
		"PmenuSbar",
		"PmenuThumb",
	},
	exclude_groups = {
		"StatusLine", -- keep active statusline visible
		"TabLine", -- keep bufferline readable
		"TabLineFill",
	},
	on_clear = function()
		-- re-apply any highlights that get blown away on colorscheme reload
		vim.cmd("highlight WinSeparator guifg=#444444")
	end,
})
