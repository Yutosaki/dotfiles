-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end

vim.opt.rtp:prepend(lazypath)
vim.opt.display:append("lastline")
vim.g.neovide_font_name = "Hack Nerd Font Mono"

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
	vim.fn.getchar()
	vim.cmd.quit()
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.display = "lastline"
		vim.opt.scrolloff = 0
	end,
})

-- -------------------------------------------------------------------------
-- クリップボード設定 (OSC 52 対応)
-- Docker / SSH 環境でもホストOSのクリップボードと同期します
-- -------------------------------------------------------------------------
if vim.ui.clipboard and vim.ui.clipboard.osc52 then
	-- Neovim 0.10+ の標準機能を使用
	local function copy(lines, _)
		require("vim.ui.clipboard.osc52").copy("+")(lines)
	end

	local function paste()
		return require("vim.ui.clipboard.osc52").paste("+")()
	end

	vim.g.clipboard = {
		name = "osc52",
		copy = {
			["+"] = copy,
			["*"] = copy,
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
	-- 常にシステムクリップボードを使う設定
	vim.opt.clipboard = "unnamedplus"
end

-- -------------------------------------------------------------------------
-- 設定読み込み (ここがファイルの最後に来るようにする)
-- -------------------------------------------------------------------------
require("lazy_setup")
require("polish")
