local transparent = (vim.env.VIM_TRANSPARENT or ""):lower()
vim.g.transparent_background = transparent == "1" or transparent == "true" or transparent == "on"

local version = vim.version()
local no_lazy = vim.env.NO_LAZY

require("config.vim")

if version.major > 0 or version.minor >= 12 then
	vim.lsp.log.set_level("ERROR")
else
	vim.lsp.set_log_level("ERROR")
end

if (version.major > 0 or version.minor >= 10) and not no_lazy then
	require("config.lazy")
	vim.cmd.colorscheme("koda")
else
	require("config.nolazy")
	vim.notify(
		"lazy.nvim and colorscheme disabled: " .. (no_lazy and "NO_LAZY env set" or "Neovim < 0.10"),
		vim.log.levels.WARN
	)
	vim.cmd.colorscheme("unokai")
end

require("config.remap")

function EnableTransparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
end
-- EnableTransparent()
