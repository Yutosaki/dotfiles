return {
	"stevearc/oil.nvim",
	opts = {},
	-- 依存関係（アイコン表示のため）
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			-- ここに詳細な設定を書けます
			view_options = {
				show_hidden = true, -- 隠しファイルを表示
			},
			-- 単純な編集（ファイル作成、名前変更など）の確認をスキップする
			skip_confirm_for_simple_edits = true,
		})
		-- oilを開くためのキーバインド（例: - キーで親ディレクトリを開く）
		vim.keymap.set("n", "<BS>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
