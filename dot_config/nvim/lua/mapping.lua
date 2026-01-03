local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- jj でインサートモードを抜ける
map("i", "jj", "<ESC>", opts)

-----------------------------------------
-- 1. 画面移動を爆速にする
-----------------------------------------
-- Ctrl + hjkl でウィンドウ間を移動できるようにします
-- (デフォルトだと Ctrl+w を押してから h とか押さないといけないのが面倒なので)
map("n", "<C-h>", "<C-w>h", opts) -- 左のウィンドウへ
map("n", "<C-j>", "<C-w>j", opts) -- 下のウィンドウへ
map("n", "<C-k>", "<C-w>k", opts) -- 上のウィンドウへ
map("n", "<C-l>", "<C-w>l", opts) -- 右のウィンドウへ

-----------------------------------------
-- 2. インデント操作の改善 (Visual Mode)
-----------------------------------------
-- 範囲選択して > でインデントすると、選択範囲が解除されてしまうのを防ぎます。
-- 連続で > > > と押せるようになります。
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-----------------------------------------
-- 3. x で文字を消した時にヤンク（コピー）しない
-----------------------------------------
-- "x" で一文字消すと、それがクリップボードに入ってしまい、
-- ペーストしようとしてたものが上書きされる事故を防ぎます。
map("n", "x", '"_x', opts)

-----------------------------------------
-- 5. 行の移動 (Visual Mode)
-----------------------------------------
-- 選択した行を J や K で上下に移動させます（VSCodeの Alt+Up/Down のような動き）
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- 検索系 (Telescope)
-- Space + ff : ファイル名で検索
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
-- Space + fw : ファイル内の文字で検索 (Live Grep)
map("n", "<Leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Find words" })
-- Space + fb : 開いているバッファを検索
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
-- Space + fh : ヘルプドキュメントを検索
map("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help" })
