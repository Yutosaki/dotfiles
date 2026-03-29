return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	cond = not vim.g.vscode,
	ft = { "markdown", "md", "mdx" },
	keys = {
		{ "<Space>sm", ":RenderMarkdown toggle<CR>", desc = "Markdown表示切り替え" },
	},
	---@type render.md.UserConfig
	opts = {
		render_modes = true,
		heading = {
			enabled = true,
			width = "block",
			left_pad = 0,
			right_pad = 4,
			-- 見出しのアイコンを青・水色系で統一
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			-- 背景色は後ほど config 内のハイライトグループで指定するためここでは空にする
			backgrounds = {
				"RenderMarkdownH1Bg",
				"RenderMarkdownH2Bg",
				"RenderMarkdownH3Bg",
			},
		},
		code = {
			enabled = true,
			width = "block",
			border = "thick",
			-- コードブロックの背景色を指定
			highlight = "RenderMarkdownCodeBg",
			highlight_inline = "RenderMarkdownCodeInline",
			highlight_border = "RenderMarkdownCodeBorder",
		},
		checkbox = {
			-- チェックボックスも青系に
			unchecked = { highlight = "RenderMarkdownUnchecked" },
			checked = { highlight = "RenderMarkdownChecked", scope_highlight = "@markup.strikethrough" },
		},
		pipe_table = {
			-- テーブルの枠線を青系に
			highlight = "RenderMarkdownTableBorder",
		},
		link = {
			-- リンクを明るい水色に
			highlight = "RenderMarkdownLink",
		},
	},
	config = function(_, opts)
		-- プラグインのセットアップ
		require("render-markdown").setup(opts)

		-- 🎨 青系統のハイライトを強制上書き設定
		local hl = vim.api.nvim_set_hl

		-- 1. コードブロックの背景 (深いネイビー)
		hl(0, "RenderMarkdownCodeBg", { bg = "#1b1e28", fg = "none" })
		hl(0, "RenderMarkdownCodeInline", { bg = "#242936", fg = "#add7ff" })
		hl(0, "RenderMarkdownCodeBorder", { fg = "#303650" })

		-- 2. 見出しの背景 (深い青のグラデーション)
		hl(0, "RenderMarkdownH1Bg", { bg = "#1e3a5f", fg = "#add7ff", bold = true })
		hl(0, "RenderMarkdownH2Bg", { bg = "#162e4d", fg = "#89ddff" })
		hl(0, "RenderMarkdownH3Bg", { bg = "#10223b", fg = "#73daca" })

		-- 3. その他パーツ (シアン・ブルー)
		hl(0, "RenderMarkdownTableBorder", { fg = "#506477" })
		hl(0, "RenderMarkdownLink", { fg = "#89ddff", underline = true })
		hl(0, "RenderMarkdownUnchecked", { fg = "#506477" })
		hl(0, "RenderMarkdownChecked", { fg = "#add7ff" })

		-- 見出し自体の文字色も青系に固定
		hl(0, "@markup.heading.1.markdown", { fg = "#add7ff", bold = true })
		hl(0, "@markup.heading.2.markdown", { fg = "#89ddff", bold = true })
	end,
}
