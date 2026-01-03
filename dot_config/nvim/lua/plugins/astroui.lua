return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "poimandres",

    highlights = {
      -- 【init】: 全テーマ共通の設定
      init = {
        -- bg: カーソルの色 (Poimandresのシアン #5DE4C7)
        -- fg: 下の文字の色 (これを暗い色 #1b1e28 に固定すると読める)
        Cursor = { bg = "#5DE4C7", fg = "#1b1e28" },
        -- 念のため入力モード(iCursor)なども統一しておくと綺麗です
        iCursor = { bg = "#5DE4C7", fg = "#1b1e28" },

        -- ■ 検索ハイライト（青系で統一）
        -- Search: 他のマッチ箇所（少し濃いめの青背景＋白文字）
        Search = { bg = "#3D59A1", fg = "#ffffff", bold = true },
        -- CurSearch: 現在カーソルがある箇所（明るい水色背景＋黒文字で強調）
        CurSearch = { bg = "#89ddff", fg = "#1b1e28", bold = true },
        -- IncSearch: 入力中の文字（CurSearchと同じにするのが一般的）
        IncSearch = { bg = "#89ddff", fg = "#1b1e28", bold = true },
      },

      -- 【poimandres】: Poimandres 専用設定
      poimandres = {
        Comment = { fg = "#767C9D", italic = true },
        CursorLineNr = { fg = "#5DE4C7", bold = true },
      },
    },

    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
