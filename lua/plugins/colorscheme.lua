return {
	{
		"sainnhe/everforest", -- https://github.com/sainnhe/everforest
		config = function()
			vim.cmd([[
				set background=dark

				if has("termguicolors")
					set termguicolors
				end

				let g:everforest_background = "hard"
				let g:everforest_better_performance = 1
				let g:everforest_enable_italic = 1
				let g:everforest_disable_italic_comment = 1
				let g:everforest_cursor = "auto"
				let g:everforest_transparent_background = 2
			]])
		end,
	},
	{
		"xero/miasma.nvim", -- https://github.com/xero/miasma.nvim
	},
	{
		"sainnhe/sonokai", -- https://github.com/sainnhe/sonokai
	},
	{
		"AlexvZyl/nordic.nvim", -- https://github.com/AlexvZyl/nordic.nvim
		config = function()
			require("nordic").load()
		end,
	},
	{
		"navarasu/onedark.nvim", -- https://github.com/navarasu/onedark.nvim
		config = function()
			require("onedark").setup({
				style = "warmer", -- dark, darker, cool, deep, warm, warmer, light
			})
			require("onedark").load()
		end,
	},
	{
		"projekt0n/github-nvim-theme", -- https://github.com/projekt0n/github-nvim-theme
	},
	{
		"sho-87/kanagawa-paper.nvim", -- https://github.com/sho-87/kanagawa-paper.nvim
	},
}
