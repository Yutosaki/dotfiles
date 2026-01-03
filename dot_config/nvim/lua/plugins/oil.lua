return {
	"stevearc/oil.nvim",
	opts = {},
	-- 依存関係（アイコン表示のため）
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			-- ここに詳細な設定を書けます
			view_optionw = {
				show_hidden = true, -- 隠しファイルを表示
			},
		})
		-- oilを開くためのキーバインド（例: - キーで親ディレクトリを開く）
		vim.keymap.set("n", "<BS>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
