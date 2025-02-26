
-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.showmode = true
vim.opt.laststatus = 2
vim.opt.wrap = true
vim.opt.linebreak = true

vim.filetype.add {
  pattern = {        -- 先にパターンを評価
    ["~/%.config/foo/.*"] = "fooscript",
  },
  filename = {       -- 次にファイル名を評価
    ["Foofile"] = "fooscript",
  },
  extension = {      -- 最後に拡張子を評価
    foo = "fooscript",
  },
}

local keymap = vim.keymap

keymap.set('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true })
keymap.set('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true })
-- ビジュアルモード
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- ビジュアルモードで "p" に "_dP" をマッピング
keymap.set("x", "p", '"_dP', {noremap = true, silent = true})
