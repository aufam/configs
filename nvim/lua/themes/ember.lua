return {
	"ember-theme/nvim",
	name = "ember",
	priority = 1000,
	config = function()
		require("ember").setup({
			variant = "ember", -- "ember" | "ember-soft" | "ember-light"
			styles = {
				comments = { italic = true },
				keywords = { bold = true },
				functions = {},
				types = { bold = true },
			},
			transparent = vim.g.transparent_background, -- transparent editor background
			transparent_floats = nil, -- follows `transparent` by default; set explicitly to override
			dark_variant = "ember", -- used by `ember-auto` when background = "dark"
			light_variant = "ember-light", -- used by `ember-auto` when background = "light"
			on_colors = nil, -- function(palette) - modify palette before theme builds
			on_highlights = nil, -- function(highlights, theme) - modify highlight groups
		})
	end,
}
