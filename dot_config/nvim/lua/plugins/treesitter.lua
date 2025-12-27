---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "make",
      "bash",

      "lua",
      "vim",

      "dockerfile",
      "toml",
      "gitignore",
      "json",
      "markdown"
    },
  },
}
