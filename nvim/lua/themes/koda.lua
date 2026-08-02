return {
	"oskarnurm/koda.nvim",
	config = function()
		require("koda").setup({
			transparent = vim.g.transparent_background,

			-- Automatically enable highlights only for plugins installed by your plugin manager
			-- Currently only supports `lazy.nvim`, `mini.deps` and `vim.pack`
			auto = true, -- disable to load ALL available plugin highlights

			cache = true, -- caches the theme for better performance

			-- Style to be applied to different syntax groups
			-- Common use case would be to set either `italic = true` or `bold = true` for a desired group
			-- See `:help nvim_set_hl` for more valid values
			styles = {
				functions = { bold = true, italic = true },
				keywords = { bold = false, italic = true },
				comments = { italic = true },
				strings = { italic = true },
				constants = { bold = true }, -- includes numbers, booleans
			},

			-- Override colors for the active variant
			-- Available keys (e.g., 'func') can be found in lua/koda/palette/
			colors = {
				-- operator = "#95cb82",
				-- keyword = "#d9ba73",
				-- func = "#FFFFFF",
				type = "#FFFFFF",
			},

			-- You can modify or extend highlight groups using the `on_highlights` configuration option
			-- Any changes made take effect when highlights are applied
			on_highlights = function(hl, c)
				-- hl.LineNr = { fg = c.info } -- change a specific highlight to use a different palette color
				-- hl.Comment = { fg = c.emphasis, italic = true } -- modify a syntax group (add bold, italic, etc)
				-- hl.RainbowDelimiterRed = { fg = "#fb2b2b" } -- add a custom highlight group for another plugin
			end,
		})
	end,
}
