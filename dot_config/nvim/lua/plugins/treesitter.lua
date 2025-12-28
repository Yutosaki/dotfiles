---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
    },
    ensure_installed = {
      "c",
      "cpp",
      "make",
      "bash",

      "lua",
      "vim",

      "dockerfile",
      "yaml",
      "toml",
      "gitignore",
      "json",
      "markdown"
    },
  },
}
