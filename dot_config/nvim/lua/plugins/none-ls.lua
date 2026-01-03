-- Customize None-ls sources

---@type LazySpec
return {
	"nvimtools/none-ls.nvim",
	opts = function(_, opts)
		local null_ls = require("null-ls")

		opts.sources = require("astrocore").list_insert_unique(opts.sources, {
			-- Luaの整形
			null_ls.builtins.formatting.stylua,
			-- C/C++の整形
			null_ls.builtins.formatting.clang_format,
		})
	end,
}
