return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "User AstroFile",
  opts = function()
    -- 1. 色の定義（寒色系・Winter Theme）
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4252" })    -- 背景（暗いグレー）

      -- ▼ スコープ用の寒色パレット
      vim.api.nvim_set_hl(0, "WinterBlue", { fg = "#88C0D0" })   -- Level 1
      vim.api.nvim_set_hl(0, "WinterTeal", { fg = "#8FBCBB" })   -- Level 2
      vim.api.nvim_set_hl(0, "WinterPurple", { fg = "#B48EAD" }) -- Level 3
      vim.api.nvim_set_hl(0, "WinterCyan", { fg = "#81A1C1" })   -- Level 4
      vim.api.nvim_set_hl(0, "WinterNavy", { fg = "#5E81AC" })   -- Level 5
      vim.api.nvim_set_hl(0, "WinterMint", { fg = "#A3BE8C" })   -- Level 6
    end)

    return {
      -- 普段の線（全レベル共通）
      indent = {
        char = "│",
        highlight = "IblIndent", -- グレーにする
      },

      -- カーソルがある場所（スコープ）の設定
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,

        -- ▼ 深さに応じてこのリストの色を順番に使います
        highlight = {
          "WinterBlue",
          "WinterTeal",
          "WinterPurple",
          "WinterCyan",
          "WinterNavy",
          "WinterMint",
        },

        -- ▼ Luaのテーブル{}などを階層として認識させる設定
        include = {
          node_type = {
            lua = {
              "chunk",
              "do_statement",
              "while_statement",
              "repeat_statement",
              "if_statement",
              "then",
              "else",
              "elseif",
              "function_definition",
              "function_declaration",
              "function",
              "arguments",
              "table_constructor", -- これが {} のこと
              "field",             -- テーブルの中身
            },
          },
        },
      },
    }
  end,
}
