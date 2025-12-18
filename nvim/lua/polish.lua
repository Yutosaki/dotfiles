
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
vim.opt.display:append("lastline")

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

local keymap = vim.keymap

-- Vertical Split: <C-j> then \
keymap.set('n', '<C-j>\\', ':vsplit<CR>', { noremap = true, silent = true, desc = "Vertical Split" })

-- Horizontal Split: <C-j> then -
keymap.set('n', '<C-j>-', ':split<CR>', { noremap = true, silent = true, desc = "Horizontal Split" })

-- Move between splits easily
keymap.set('n', '<C-h>', '<C-w>h', { silent = true }) -- Left
keymap.set('n', '<C-j>', '<C-w>j', { silent = true }) -- Down
keymap.set('n', '<C-k>', '<C-w>k', { silent = true }) -- Up
keymap.set('n', '<C-l>', '<C-w>l', { silent = true }) -- Right

-- ソースファイルの実装にジャンプする関数
vim.keymap.set('n', 'gi', function()
  local word = vim.fn.expand('<cword>') -- カーソル下の単語
  local src_dir = "src"
  local found = false
  
  -- 現在のワークスペースのルートを取得
  local workspace_root = vim.fn.getcwd()
  local src_path = workspace_root .. "/" .. src_dir
  
  -- src ディレクトリが存在するか確認
  if vim.fn.isdirectory(src_path) == 1 then
    -- Cファイルのリストを取得
    local files = vim.fn.glob(src_path .. "/*.c", false, true)
    
    -- 各ファイルをチェック
    for _, file in ipairs(files) do
      -- ファイルの内容を読み取り
      local content = table.concat(vim.fn.readfile(file), "\n")
      
      -- 関数定義のパターン (関数名の前に戻り値タイプと空白、後ろに括弧)
      local pattern = "[%w%*]+%s+" .. vim.fn.escape(word, "^$()%.[]*+-?") .. "%s*%("
      local start_pos = content:find(pattern)
      
      if start_pos then
        -- 関数定義が見つかったファイルを開く
        vim.cmd("edit " .. file)
        
        -- 関数定義の行番号を見つける
        local line_num = 1
        local pos = 1
        while pos < start_pos do
          pos = content:find("\n", pos) + 1
          if not pos then break end
          line_num = line_num + 1
        end
        
        -- カーソルを関数定義の行に移動
        vim.api.nvim_win_set_cursor(0, {line_num, 0})
        found = true
        break
      end
    end
  end
  
  if not found then
    -- 見つからなかった場合、通常の定義ジャンプを試す
    vim.lsp.buf.definition()
  end
end, { noremap = true, silent = true, desc = "Go to implementation" })
