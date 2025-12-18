return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy", -- Load the plugin slightly later for better startup time
    opts = {
      options = {
        mode = "buffers", -- Use tabs for open buffers
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          }
        },
      },
    },
  },
}
