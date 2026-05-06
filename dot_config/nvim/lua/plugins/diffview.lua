-- lua/plugins/diffview.lua

---@type LazySpec
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  opts = {},
  config = function(_, opts)
    require("diffview").setup(opts)
  end,
}
