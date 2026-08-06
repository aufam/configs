return {
	"metalelf0/kintsugi-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kintsugi").setup({
			variant = "dark", -- "dark" | "flared"
			transparent = vim.g.transparent_background, -- true | false
			terminal_colors = true,
			bold_keywords = true,
			italic_comments = true,
		})
	end,
}
