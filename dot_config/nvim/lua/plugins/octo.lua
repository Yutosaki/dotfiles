return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		picker = "telescope",
		enable_builtin = true,
		use_local_fs = false,
		reviews = {
			auto_show_threads = true,
			focus = "right",
		},
	},
	keys = {
		{ "<leader>oi", "<CMD>Octo issue list<CR>", desc = "List GitHub Issues" },
		{ "<leader>op", "<CMD>Octo pr list<CR>", desc = "List GitHub PullRequests" },
		{ "<leader>on", "<CMD>Octo notification list<CR>", desc = "List GitHub Notifications" },
	},
}
