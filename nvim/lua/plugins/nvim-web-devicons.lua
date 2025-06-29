--return {
--  "nvim-tree/nvim-web-devicons",
--  opts = {} 
--}

return {
  "kyazdani42/nvim-web-devicons",
  config = function()
    print("nvim-web-devicons is loaded in plugins")
    require("nvim-web-devicons").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
