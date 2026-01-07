-- C言語用の定義ジャンプ関数
local function jump_to_c_implementation()
	local word = vim.fn.expand("<cword>") -- カーソル下の単語
	local src_dir = "src"
	local found = false
	local workspace_root = vim.fn.getcwd()
	local src_path = workspace_root .. "/" .. src_dir

	if vim.fn.isdirectory(src_path) == 1 then
		local files = vim.fn.glob(src_path .. "/*.c", false, true)
		for _, file in ipairs(files) do
			local content = table.concat(vim.fn.readfile(file), "\n")
			-- 関数定義パターン検索
			local pattern = "[%w%*]+%s+" .. vim.fn.escape(word, "^$()%.[]*+-?") .. "%s*%("
			local start_pos = content:find(pattern)

			if start_pos then
				vim.cmd("edit " .. file)
				local line_num = 1
				local pos = 1
				while pos < start_pos do
					pos = content:find("\n", pos) + 1
					if not pos then
						break
					end
					line_num = line_num + 1
				end
				vim.api.nvim_win_set_cursor(0, { line_num, 0 })
				found = true
				break
			end
		end
	end

	if not found then
		vim.lsp.buf.definition()
	end
end

return {
	-----------------------------------------------------------------------------
	-- Normal Mode (n)
	-----------------------------------------------------------------------------
	n = {
		-- 1. バッファ移動 (Shift + h/l)
		["L"] = {
			function()
				require("astrocore.buffer").nav(vim.v.count1)
			end,
			desc = "Next buffer",
		},
		["H"] = {
			function()
				require("astrocore.buffer").nav(-vim.v.count1)
			end,
			desc = "Previous buffer",
		},
		["C"] = {
			function()
				require("astrocore.buffer").close()
			end,
			desc = "Close buffer safely",
		},

		-- 3. 画面分割 (Ctrl + j のあとに \ や - )
		["<C-j>\\"] = { ":vsplit<CR>", desc = "Vertical Split" },
		["<C-j>-"] = { ":split<CR>", desc = "Horizontal Split" },

		-- 4. 画面移動 (Ctrl + hjkl)
		["<C-h>"] = { "<C-w>h", desc = "Move to left window" },
		["<C-j>"] = { "<C-w>j", desc = "Move to bottom window" },
		["<C-k>"] = { "<C-w>k", desc = "Move to top window" },
		["<C-l>"] = { "<C-w>l", desc = "Move to right window" },

		-- 5. 行の移動
		["J"] = { ":m .+1<CR>==", desc = "Move line down" },
		["K"] = { ":m .-2<CR>==", desc = "Move line up" },

		-- 6. 特殊機能: C言語実装へジャンプ (gi)
		["gi"] = { jump_to_c_implementation, desc = "Go to C implementation" },

		-- 7. その他
		["x"] = { '"_x', desc = "Delete character without yank" },
		["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "Find files" },
		["<leader>fw"] = { "<cmd>Telescope live_grep<cr>", desc = "Find words" },
		["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", desc = "Find help" },
		["<Leader>t"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
	},

	-----------------------------------------------------------------------------
	-- Visual Mode (v)
	-----------------------------------------------------------------------------
	v = {
		["J"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
		["K"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },
		["<"] = { "<gv", desc = "Unindent line" },
		[">"] = { ">gv", desc = "Indent line" },
	},

	-----------------------------------------------------------------------------
	-- Visual Block Mode (x)
	-----------------------------------------------------------------------------
	x = {
		["p"] = { '"_dP', desc = "Paste without yanking" },
	},

	-----------------------------------------------------------------------------
	-- Insert Mode (i)
	-----------------------------------------------------------------------------
	i = {
		["jj"] = { "<Esc>", desc = "Escape insert mode" },
	},

	-----------------------------------------------------------------------------
	-- Terminal Mode (t)
	-----------------------------------------------------------------------------
	t = {
		["jj"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
	},
}
