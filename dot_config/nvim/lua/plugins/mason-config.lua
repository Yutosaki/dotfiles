-- Customize Mason plugins
--
-- ツール（LSP, Formatter, Linter）のインストール管理を Mason から `mise` へ移行
--
-- 注意:
-- Mason UI (:Mason) での確認用としてプラグイン自体は残していますが、
-- 自動インストール (ensure_installed) は原則 `mise` 側に任せます。

---@type LazySpec
return {
	-- use mason-lspconfig to configure LSP installations
	{
		"williamboman/mason-lspconfig.nvim",
		-- overrides `require("mason-lspconfig").setup(...)`
		opts = {
			-- mise (config.toml) で管理するため、ここでは自動インストールしない
			ensure_installed = {},
		},
	},
	-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
	{
		"jay-babu/mason-null-ls.nvim",
		-- overrides `require("mason-null-ls").setup(...)`
		opts = {
			-- mise (config.toml) で管理するため、ここでは自動インストールしない
			ensure_installed = {
				-- "stylua",
				-- "clang-format",
			},
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		-- overrides `require("mason-nvim-dap").setup(...)`
		opts = {
			ensure_installed = {
				-- debuggers を mise で管理する場合はここも空にする
			},
		},
	},
}
