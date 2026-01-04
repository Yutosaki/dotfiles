return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "User AstroFile",
	opts = function(_, opts)
		-- 1. Colors
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4252" })
			vim.api.nvim_set_hl(0, "WinterBlue", { fg = "#88C0D0" })
			vim.api.nvim_set_hl(0, "WinterTeal", { fg = "#8FBCBB" })
			vim.api.nvim_set_hl(0, "WinterPurple", { fg = "#B48EAD" })
			vim.api.nvim_set_hl(0, "WinterCyan", { fg = "#81A1C1" })
			vim.api.nvim_set_hl(0, "WinterNavy", { fg = "#5E81AC" })
			vim.api.nvim_set_hl(0, "WinterMint", { fg = "#A3BE8C" })
		end)

		opts.indent = { char = "│", highlight = "IblIndent" }
		opts.scope = opts.scope or {}
		opts.scope.enabled = true
		opts.scope.show_start = false
		opts.scope.show_end = false
		opts.scope.highlight = {
			"WinterBlue",
			"WinterTeal",
			"WinterPurple",
			"WinterCyan",
			"WinterNavy",
			"WinterMint",
		}

		-- 2. Define Node Types
		opts.scope.include = opts.scope.include or {}
		opts.scope.include.node_type = opts.scope.include.node_type or {}

		-- Lua
		opts.scope.include.node_type.lua = {
			"chunk",
			"do_statement",
			"while_statement",
			"repeat_statement",
			"if_statement",
			"then",
			"else",
			"elseif",
			"function_definition",
			"function_declaration",
			"function",
			"arguments",
			"table_constructor",
			"field",
		}

		-- Docker
		opts.scope.include.node_type.dockerfile = {
			"from_instruction",
			"run_instruction",
			"cmd_instruction",
			"copy_instruction",
			"env_instruction",
			"workdir_instruction",
		}

		-- YAML
		opts.scope.include.node_type.yaml = {
			"block_mapping_pair",
			"block_sequence_item",
		}

		-- TOML
		opts.scope.include.node_type.toml = {
			"table",
			"pair",
		}

		-- JSON
		opts.scope.include.node_type.json = {
			"object",
			"array",
		}

		-- Bash (Added)
		opts.scope.include.node_type.bash = {
			"function_definition",
			"if_statement",
			"while_statement",
			"for_statement",
			"case_statement",
			"subshell",
			"command_substitution",
		}

		return opts
	end,
}
