return {
	"kylechui/nvim-surround",
	version = "*", -- 最新の安定版を使用
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- デフォルトの設定を使用（必要であればここでカスタマイズ可能）
		})
	end,
}
