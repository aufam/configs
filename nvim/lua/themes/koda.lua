local default_colors = {
	allaman = {
		bg = "#101010",
		fg = "#b0b0b0",
		dim = "#000000",
		line = "#777777",
		keyword = "#777777",
		comment = "#bcbcbc",
		border = "#ffffff",
		emphasis = "#ffffff",
		func = "#ffffff",
		string = "#ffffff",
		const = "#d9ba73",
		highlight = "#458ee6",
		info = "#8ebeec",
		success = "#86cd82",
		warning = "#d9ba73",
		danger = "#ff7676",
		green = "#14ba19",
		orange = "#f54d27",
		red = "#701516",
		pink = "#f2a4db",
		cyan = "#5abfb5",
	},

	warm_paper = {
		operator = "#A4CF92",
		keyword = "#D6B76D",
		bg = "#181614",
		fg = "#CEC6BD",
		dim = "#706A63",
		line = "#302C28",
		type = "#9F988F",
		comment = "#7D766F",
		border = "#E8E2DB",
		emphasis = "#FFFFFF",
		func = "#F8F6F2",
		string = "#F5F2EC",
		char = "#F5F2EC",
		special = "#F8F6F2",
		const = "#D6B76D",
		highlight = "#5F9EE6",
		info = "#8DBCE8",
		success = "#97D08A",
		warning = "#D6B76D",
		danger = "#EE8686",
		green = "#53BF5F",
		orange = "#E98A52",
		red = "#A74A4A",
		pink = "#E2B3D4",
		cyan = "#69BDBA",
	},

	slate = {
		operator = "#A8D5A2",
		keyword = "#D7C08A",
		bg = "#141516",
		fg = "#D1D4D8",
		dim = "#6C7077",
		line = "#2F3235",
		type = "#A0A5AB",
		comment = "#7C838B",
		border = "#E5E7EB",
		emphasis = "#FFFFFF",
		func = "#F6F7F9",
		string = "#F0F2F4",
		char = "#F0F2F4",
		special = "#F6F7F9",
		const = "#D7C08A",
		highlight = "#70A8F5",
		info = "#9CC7F7",
		success = "#9BD69A",
		warning = "#D7C08A",
		danger = "#F28B82",
		green = "#5BCB6D",
		orange = "#F39C6B",
		red = "#B85454",
		pink = "#DDB8E8",
		cyan = "#76C8D3",
	},

	monochrome = {
		operator = "#C5C5C5",
		keyword = "#F0D48A",
		bg = "#121212",
		fg = "#D8D8D8",
		dim = "#656565",
		line = "#303030",
		type = "#AAAAAA",
		comment = "#808080",
		border = "#ECECEC",
		emphasis = "#FFFFFF",
		func = "#FFFFFF",
		string = "#ECECEC",
		char = "#ECECEC",
		special = "#F5F5F5",
		const = "#F0D48A",
		highlight = "#8FB8E8",
		info = "#B7D5F2",
		success = "#B8D8B8",
		warning = "#F0D48A",
		danger = "#F29B9B",
		green = "#9BC79B",
		orange = "#D9A26E",
		red = "#BB6A6A",
		pink = "#D9C0D9",
		cyan = "#9FCACA",
	},

	-- Override colors for the active variant
	-- Available keys (e.g., 'func') can be found in lua/koda/palette/
	colors = {
		-- operator = "#95cb82",
		-- keyword = "#d9ba73",
		-- func = "#FFFFFF",
		type = "#FFFFFF",
	},
}

-- You can modify or extend highlight groups using the `on_highlights` configuration option
-- Any changes made take effect when highlights are applied
local on_highlights = function(hl, c)
	-- hl.LineNr = { fg = c.info } -- change a specific highlight to use a different palette color
	-- hl.Comment = { fg = c.emphasis, italic = true } -- modify a syntax group (add bold, italic, etc)
	-- hl.RainbowDelimiterRed = { fg = "#fb2b2b" } -- add a custom highlight group for another plugin
	hl.LspReferenceText = { fg = c.highlight } -- change vim.lsp.buf.document_highlight()
end

return {
	"oskarnurm/koda.nvim",
	config = function()
		require("koda").setup({
			colors = default_colors.colors,
			on_highlights = on_highlights,

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
		})
	end,
}
