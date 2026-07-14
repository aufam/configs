vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.cursorline = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.list = true
vim.opt.listchars = "tab:  ,trail:-"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"

vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

if vim.fn.has("unnamedplus") == 1 then
	vim.opt.clipboard = "unnamed,unnamedplus"
end

vim.cmd([[
  syntax match TodoComment /\v<(TODO|FIXME|NOTE):?/
  highlight default link TodoComment Todo
]])

vim.filetype.add({
	pattern = {
		["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
	},
})

function BufferList()
	local result = {}
	local current_buf = vim.api.nvim_get_current_buf()

	local idx = 1
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.buflisted(buf) == 1 then
			local name = vim.fn.bufname(buf)
			name = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
			local is_current = (buf == current_buf) and "*" or " "
			local is_modified = vim.api.nvim_buf_get_option(buf, "modified") and "+" or ""
			local is_readonly = not vim.api.nvim_buf_get_option(buf, "modifiable")
				or vim.api.nvim_buf_get_option(buf, "readonly")
			local ro_symbol = is_readonly and "[-]" or ""
			table.insert(result, string.format("%s%d:%s%s%s", is_current, idx, name, is_modified, ro_symbol))
			idx = idx + 1
		end
	end

	return table.concat(result, " ")
end

function ModeName()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		[""] = "V-BLOCK", -- CTRL-V
		c = "COMMAND",
		R = "REPLACE",
		s = "SELECT",
	}

	local mode_code = vim.fn.mode()
	return modes[mode_code] or "OTHER"
end

function FileTypeIcon()
	local icons = {
		["c"] = " ",
		["cpp"] = " ",
		["cmake"] = " ",
		["go"] = " ",
		["rust"] = " ",
		["zig"] = " ",
		["java"] = " ",

		["javascript"] = " ",
		["typescript"] = " ",
		["html"] = " ",
		["css"] = " ",

		["json"] = " ",
		["yaml"] = " ",
		["toml"] = " ",
		["xml"] = "󰗀 ",

		["text"] = "󰦨 ",
		["markdown"] = " ",

		["lua"] = " ",
		["vim"] = " ",
		["python"] = " ",
		["fish"] = "󰈺 ",
		["bash"] = " ",
		["sh"] = " ",
		["dockerfile"] = "󰡨 ",
	}

	local ft = vim.bo.filetype
	return icons[ft] or " "
end

function LspServers()
	local names = {}

	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		table.insert(names, client.name)
	end

	return table.concat(names, ", ")
end

vim.opt.statusline = table.concat({
	"",
	"%{v:lua.ModeName()}",
	"%{v:lua.BufferList()}",
	"%=",
	"%{&fileencoding !=# '' ? &fileencoding : &encoding}",
	"%{&fileformat}",
	"%{v:lua.LspServers()}",
	"%{v:lua.FileTypeIcon()}",
}, " ")

vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.showmode = true
vim.opt.showcmd = true

local version = vim.version()
if version.major > 0 or version.minor >= 10 then
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "󰌵",
			},
		},
	})
	vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
		config = config or {}
		config.border = "rounded"
		return vim.lsp.handlers.hover(_, result, ctx, config)
	end
else
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "javascript", "typescript", "json", "html", "css" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Create directories when saving files
-- add function to clear whitespace and \r on write
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- Border
vim.diagnostic.config({ float = { border = "rounded" } })
