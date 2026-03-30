return {
	"otavioschwanck/github-pr-reviewer.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		-- 🛠 1. Neovim 本体の差分表示設定（行をピッタリ揃える）
		vim.opt.diffopt:append("filler")
		vim.opt.diffopt:append("internal")
		vim.opt.diffopt:append("indent-heuristic")

		local pr = require("github-pr-reviewer")

		pr.setup({
			-- 🚀 README最新仕様：トップレベルに設定を配置
			vertical_split = true, -- 最初から左右分割にする
			open_files_on_review = true, -- レビュー開始時にファイルを開く
			show_floats = true, -- 右上のヘルプを表示

			-- ⌨️ キー設定（README準拠）
			diff_view_toggle_key = "\\", -- これで \ が左右分割の切り替えになる
			mark_as_viewed_key = "<CR>",
			toggle_floats_key = "<C-r>",
			next_hunk_key = "]h",
			prev_hunk_key = "[h",
			next_file_key = "]f",
			prev_file_key = "[f",
		})

		-- 🛠 2. キーバインドの整理（競合を完全に排除）
		local key_opts = { silent = true, noremap = true }

		-- メインメニュー（これが一番大事！）
		vim.keymap.set("n", "<leader>pp", "<cmd>PRReviewMenu<cr>", { desc = "PR Review Menu", unpack(key_opts) })

		-- レビュー・ワークフロー
		vim.keymap.set("n", "<leader>pr", "<cmd>PRReview<cr>", { desc = "レビュー開始", unpack(key_opts) })
		vim.keymap.set("n", "<leader>pc", "<cmd>PRReviewCleanup<cr>", { desc = "レビュー終了", unpack(key_opts) })
		vim.keymap.set("n", "<leader>pi", "<cmd>PRInfo<cr>", { desc = "PR情報を表示", unpack(key_opts) })
		vim.keymap.set("n", "<leader>po", "<cmd>PROpen<cr>", { desc = "ブラウザで開く", unpack(key_opts) })

		-- 💬 コメント関連
		-- pa をコメント追加（保留モード）に割り当て
		vim.keymap.set(
			"n",
			"<leader>pa",
			"<cmd>PRPendingComment<cr>",
			{ desc = "コメント追加(保留)", unpack(key_opts) }
		)
		vim.keymap.set(
			"n",
			"<leader>pv",
			"<cmd>PRListAllComments<cr>",
			{ desc = "全コメント表示", unpack(key_opts) }
		)
		vim.keymap.set("n", "<leader>pe", "<cmd>PREditComment<cr>", { desc = "コメント編集", unpack(key_opts) })

		-- 🚀 送信アクション
		vim.keymap.set("n", "<leader>ps", "<cmd>PRApprove<cr>", { desc = "承認して送信", unpack(key_opts) })
		vim.keymap.set(
			"n",
			"<leader>px",
			"<cmd>PRRequestChanges<cr>",
			{ desc = "修正要求して送信", unpack(key_opts) }
		)

		-- 🛠 3. \ キーが他の設定に奪われるのを防ぐ
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "ghpr",
			callback = function()
				vim.keymap.set("n", "\\", function()
					pr.toggle_split()
				end, { buffer = true, desc = "左右分割切り替え" })
			end,
		})

		-- 🎨 4. 配色の調整（追加行を緑系に、他は青系に）
		local function set_ui_colors()
			local hl = vim.api.nvim_set_hl

			-- 🟦 差分画面：背景グレーを消す
			hl(0, "DiffChange", { bg = "NONE", fg = "NONE" })
			hl(0, "DiffText", { bg = "#1e3a5f", fg = "#00f2ff", bold = true })

			-- 🟢 追加行：リクエスト通り「緑」にします
			hl(0, "DiffAdd", { bg = "#1a3a1e", fg = "#a6e22e", force = true })

			-- 🔴 削除行：青系テーマに合う落ち着いた赤マゼンタ
			hl(0, "DiffDelete", { bg = "#3a1a2a", fg = "#f7768e", force = true })

			-- 🟦 ファイルリスト等のUI
			hl(0, "GHPRFileSelected", { fg = "#000000", bg = "#00f2ff", bold = true, force = true })
			hl(0, "GHPRFileNotViewed", { fg = "#73daca", bold = true, force = true })
			hl(0, "GHPRFileViewed", { fg = "#565f89", force = true })
			hl(0, "DiffFiller", { fg = "#3b4261", bg = "NONE", force = true })
		end

		set_ui_colors()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_ui_colors })
	end,
}
