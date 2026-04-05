return {
	"otavioschwanck/github-pr-reviewer.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		-- 1. 全体設定：コメント表示の高速化と差分設定
		vim.o.updatetime = 200
		vim.opt.diffopt:append("filler")
		vim.opt.diffopt:append("internal")

		local pr = require("github-pr-reviewer")

		pr.setup({
			vertical_split = true,
			open_files_on_review = true,
			show_floats = true,
			show_comments = true,

			-- ⌨️ キー設定：プレフィックスを Ctrl + p 系統に統一
			-- ※ AstroNvim標準の Telescope (Ctrl+p) と衝突する場合は注意してください
			diff_view_toggle_key = "\\",
			mark_as_viewed_key = "<CR>",
			toggle_floats_key = "<C-r>",
			next_hunk_key = "<C-p>j", -- 次の差分
			prev_hunk_key = "<C-p>k", -- 前の差分
			next_file_key = "<C-p>l", -- 次のファイル
			prev_file_key = "<C-p>h", -- 前のファイル
		})

		-- 2. キーバインド（リーダーキー系統）
		local key_opts = { silent = true, noremap = true }
		vim.keymap.set("n", "<leader>pp", "<cmd>PRReviewMenu<cr>", { desc = "PRメニュー", unpack(key_opts) })
		vim.keymap.set(
			"n",
			"<leader>pa",
			"<cmd>PRPendingComment<cr>",
			{ desc = "コメント追加", unpack(key_opts) }
		)
		vim.keymap.set(
			"n",
			"<leader>pv",
			"<cmd>PRListAllComments<cr>",
			{ desc = "全コメント表示", unpack(key_opts) }
		)
		vim.keymap.set("n", "<leader>pc", "<cmd>PRReviewCleanup<cr>", { desc = "レビュー終了", unpack(key_opts) })

		-- 3. 🛠 コメントバッファの `:w` エラー対策ハック
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "ghpr_comment",
			callback = function(args)
				-- 保存コマンド（:w）をフックして、プラグインの保存処理（<C-s>）をエミュレートする
				-- buftype=nofile でもエラーを出さずに保存できるようにします
				vim.api.nvim_buf_create_user_command(args.buf, "W", function()
					vim.api.nvim_input("<C-s>")
				end, { desc = "Save PR Comment" })

				-- :w を入力した時にエラーを出さず保存処理を実行
				vim.keymap.set("n", ":w<CR>", "<C-s>", { buffer = args.buf, remap = true, silent = true })
				-- :q でそのまま閉じれるように
				vim.keymap.set("n", ":q<CR>", "<cmd>q<CR>", { buffer = args.buf, silent = true })
			end,
		})

		-- 4. 🎨 配色の調整：青系統 ＋ M(Modified)への着色
		local function set_ui_colors()
			local hl = vim.api.nvim_set_hl

			-- 🟦 共通：背景グレー除去
			hl(0, "DiffChange", { bg = "NONE", fg = "NONE" })
			hl(0, "DiffText", { bg = "#1e3a5f", fg = "#00f2ff", bold = true })

			-- 🟢 追加行：緑
			hl(0, "DiffAdd", { bg = "#1a3a1e", fg = "#a6e22e", force = true })
			-- 🔴 削除行：赤
			hl(0, "DiffDelete", { bg = "#3a1a2a", fg = "#f7768e", force = true })

			-- 🟦 ファイルリストUI
			hl(0, "GHPRFileSelected", { fg = "#000000", bg = "#00f2ff", bold = true, force = true })
			hl(0, "GHPRFileNotViewed", { fg = "#73daca", bold = true, force = true })
			hl(0, "GHPRFileViewed", { fg = "#565f89", force = true })

			-- 🟪 M (Modified) ファイルへの着色（プラグインが使用する可能性のある全グループに適用）
			local m_color = { fg = "#bb9af7", bold = true, force = true }
			hl(0, "GHPRFileModified", m_color)
			hl(0, "GHPRStatusM", m_color) -- 文字 'M' 自体の色指定があれば反映

			hl(0, "DiffFiller", { fg = "#3b4261", bg = "NONE", force = true })
		end

		set_ui_colors()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_ui_colors })
	end,
}
