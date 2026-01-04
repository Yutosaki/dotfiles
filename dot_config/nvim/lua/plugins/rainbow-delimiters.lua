return {
	"HiPhish/rainbow-delimiters.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "User AstroFile",
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.api.nvim_set_hl(0, "WinterBlue", { fg = "#88C0D0" })
		vim.api.nvim_set_hl(0, "WinterTeal", { fg = "#8FBCBB" })
		vim.api.nvim_set_hl(0, "WinterPurple", { fg = "#B48EAD" })
		vim.api.nvim_set_hl(0, "WinterCyan", { fg = "#81A1C1" })
		vim.api.nvim_set_hl(0, "WinterNavy", { fg = "#5E81AC" })
		vim.api.nvim_set_hl(0, "WinterMint", { fg = "#A3BE8C" })

		require("rainbow-delimiters.setup").setup({
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				"WinterBlue",
				"WinterTeal",
				"WinterPurple",
				"WinterCyan",
				"WinterNavy",
				"WinterMint",
			},
		})
	end,
}
