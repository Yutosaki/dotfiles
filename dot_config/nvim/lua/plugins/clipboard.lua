-- DocekrやSSHを使用する時にクリップボードを使用できるように
return {
	-- クリップボード設定の強制上書き
	{
		"nvim-lua/plenary.nvim", -- 読み込みタイミング調整のためのダミー
		init = function()
			-- 1. クリップボードプロバイダを OSC 52 に固定する
			vim.g.clipboard = {
				name = "OSC 52",
				copy = {
					["+"] = require("vim.ui.clipboard.osc52").copy("+"),
					["*"] = require("vim.ui.clipboard.osc52").copy("*"),
				},
				paste = {
					["+"] = require("vim.ui.clipboard.osc52").paste("+"),
					["*"] = require("vim.ui.clipboard.osc52").paste("*"),
				},
			}

			-- 2. "unnamedplus" オプションで常にシステムクリップボードを使う
			vim.opt.clipboard = "unnamedplus"
		end,
	},
}
