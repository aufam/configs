return {
	"https://gitlab.com/motaz-shokry/gruvbox.nvim",
	name = "gruvbox",
	priority = 1000,
	config = function()
		local highlight_groups = vim.g.transparent_background
				and {
					WinBar = { bg = "NONE" },
					WinBarNC = { bg = "NONE" },
					-- Comment = { fg = "gray" },
					StatusLine = { fg = "bg1", bg = "NONE", blend = 15 },
					-- VertSplit = { fg = "bg4", bg = "bg4" },
					-- Visual = { fg = "bg_second", bg = "fg1", inherit = false },
				}
			or {}

		require("gruvbox").setup({
			highlight_groups = highlight_groups,

			variant = "hard", -- auto, hard, medium, soft, light
			dark_variant = "medium", -- hard, medium, soft
			dim_inactive_windows = false,
			extend_background_behind_borders = false,

			enable = {
				terminal = true,
				migrations = true, -- Handle deprecated options automatically
				devicons = true, -- Theming devicons with gruvbox
				lualine = true,
			},

			styles = {
				bold = true,
				italic = true,
				transparency = vim.g.transparent_background,
			},

			groups = {
				-- UI Elements
				border = "gray",
				link = "purple_lite",
				panel = "bg_second",

				-- Diagnostic levels
				error = "red_lite",
				hint = "aqua_lite",
				info = "blue_lite",
				ok = "green_lite",
				warn = "yellow_lite",
				note = "yellow_dark",
				todo = "aqua_dark",

				-- Git states
				git_add = "green_dark",
				git_change = "yellow_dark",
				git_delete = "red_dark",
				git_dirty = "orange_dark",
				git_ignore = "gray",
				git_merge = "purple_dark",
				git_rename = "blue_dark",
				git_stage = "purple_dark",
				git_text = "yellow_lite",
				git_untracked = "bg2",

				-- Headings
				h1 = "red_dark",
				h2 = "yellow_dark",
				h3 = "green_dark",
				h4 = "aqua_dark",
				h5 = "blue_dark",
				h6 = "purple_dark",
			},

			palette = {
				-- Override the builtin palette per variant
				-- hard = {
				--     bg_main = "#1D2021",
				--     fg = "#D4C5A0",
				-- },
			},

			before_highlight = function(group, highlight, palette)
				-- Disable all undercurls
				-- if highlight.undercurl then
				--     highlight.undercurl = false
				-- end
				--
				-- Change palette colour
				-- if highlight.fg == palette.blue_lite then
				--     highlight.fg = palette.purple_lite
				-- end
			end,
		})
	end,
}
