---@type LazySpec
return {
	"AstroNvim/astrocore",
	opts = function(_, opts)
		local my_maps = require("mapping")
		opts.mappings = require("astrocore").extend_tbl(opts.mappings, my_maps)

		opts.features = {
			large_buf = { size = 1024 * 256, lines = 10000 },
			autopairs = true,
			cmp = true,
			diagnostics_mode = 3,
			highlighturl = true,
			notifications = true,
		}

		opts.diagnostics = {
			virtual_text = true,
			underline = true,
		}

		opts.options = {
			opt = {
				relativenumber = false,
				number = true,
				showmode = true,
				laststatus = 2,
				wrap = true,
				linebreak = true,
				display = "lastline",

				spell = false,
				signcolumn = "yes",
			},
		}

		return opts
	end,
}
