return {
	"HiPhish/rainbow-delimiters.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "User AstroFile",
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.api.nvim_set_hl(0, "WinterBlue", { fg = "#93B8D9" })
		vim.api.nvim_set_hl(0, "WinterTeal", { fg = "#7AB0B0" })
		vim.api.nvim_set_hl(0, "WinterPurple", { fg = "#8880B0" })
		vim.api.nvim_set_hl(0, "WinterCyan", { fg = "#608590" })
		vim.api.nvim_set_hl(0, "WinterNavy", { fg = "#586985" })
		vim.api.nvim_set_hl(0, "WinterMint", { fg = "#557060" })

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
