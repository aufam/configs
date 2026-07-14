local M = {}

M.askai = { provider = "gemini" }

M.autopairs = { check_ts = true }

M.surround = {}

M.treesitter = {
	ensure_installed = {
		-- vim/nvim related
		"vim",
		"vimdoc",
		"lua",

		-- programming languages
		"c",
		"cpp",
		"cmake",
		"python",
		"go",
		"gomod",
		"gosum",
		"rust",
		"zig",
		"javascript",
		"typescript",
		"html",

		-- scripting
		"bash",
		"fish",
		"tmux",
		"make",
		"json",
		"yaml",
		"xml",
		"toml",
		"regex",

		-- stack
		"gitignore",
		"dockerfile",
		"nginx",
		"proto",
		"sql",

		-- text
		"markdown",
		"doxygen",
	},
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	modules = {},
	highlight = { enable = true },
	indent = { enable = true },
}

M.gitsigns = {
	-- signs = {
	-- 	add = { text = "┃" },
	-- 	change = { text = "┃" },
	-- 	delete = { text = "━" },
	-- 	topdelete = { text = "━" },
	-- 	changedelete = { text = "╋" },
	-- 	untracked = { text = "┃" },
	-- },
	-- signs_staged = {
	-- 	add = { text = "┃" },
	-- 	change = { text = "┃" },
	-- 	delete = { text = "━" },
	-- 	topdelete = { text = "━" },
	-- 	changedelete = { text = "╋" },
	-- },
	preview_config = {
		relative = "cursor",
		row = 1,
		col = 0,
		style = "minimal",
		border = "rounded",
	},
}

M.telescope = {
	setup = function()
		local builtin = require("telescope.builtin")
		local layout_config = { preview_width = 0.5 }

		vim.keymap.set("n", "<leader>e", function()
			builtin.find_files({ layout_config = layout_config })
		end, { desc = "Telescope: find files" })

		vim.keymap.set("n", "<leader>F", function()
			builtin.live_grep({ layout_config = layout_config })
		end, { desc = "Telescope: live grep word under cursor", silent = true, noremap = true })

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			builtin.grep_string({ layout_config = layout_config })
		end, { desc = "Telescope: live grep word under cursor", silent = true, noremap = true })

		vim.keymap.set("n", "<leader>b", function()
			builtin.buffers({ layout_config = layout_config })
		end, { desc = "Telescope: show buffers" })

		vim.keymap.set("n", "<leader>gf", function()
			builtin.git_files({
				layout_config = layout_config,
				git_command = { "git", "ls-files", "--modified", "--other", "--exclude-standard" },
			})
		end, { desc = "Telescope: show modified files" })
	end,
}

return M
