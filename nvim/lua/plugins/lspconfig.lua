local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover documentation" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to declaration" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to implementation" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Find references" })
	vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, { buffer = bufnr, desc = "LSP: Show diagnostics" })
	vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code action" })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.format, { buffer = bufnr, desc = "LSP: Format file", silent = true })
end

local enable_formatter = function(augroup, client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({
			group = augroup,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
				})
			end,
		})
	end
end

local get_python_path = function(root_dir)
	local paths = {
		root_dir .. "/venv/bin/python",
		root_dir .. "/.venv/bin/python",
		root_dir .. "/env/bin/python",
		root_dir .. "/.env/bin/python",
		root_dir .. "/venv/Scripts/python.exe", -- Windows
		root_dir .. "/.venv/Scripts/python.exe", -- Windows
		root_dir .. "/env/Scripts/python.exe", -- Windows
		root_dir .. "/.env/Scripts/python.exe", -- Windows
	}
	for _, path in ipairs(paths) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end
	return nil
end

local function get_cmake_dir()
	local root_dir = vim.fn.getcwd()

	if
		vim.fn.isdirectory(root_dir .. "/build") == 1
		and vim.fn.filereadable(root_dir .. "/build/compile_commands.json") == 1
	then
		return root_dir .. "/build"
	elseif
		vim.fn.isdirectory(root_dir .. "/debug") == 1
		and vim.fn.filereadable(root_dir .. "/debug/compile_commands.json") == 1
	then
		return root_dir .. "/debug"
	elseif
		vim.fn.isdirectory(root_dir .. "/release") == 1
		and vim.fn.filereadable(root_dir .. "/release/compile_commands.json") == 1
	then
		return root_dir .. "/release"
	else
		return nil
	end
end

local function get_compile_commands_dir(cmake_dir)
	local root_dir = vim.fn.getcwd()
	if vim.fn.filereadable(root_dir .. "/compile_commands.json") == 1 then
		return root_dir
	elseif cmake_dir ~= nil then
		return cmake_dir
	else
		return nil
	end
end

local function progress(client_id, token, value)
	vim.schedule(function()
		vim.lsp.handlers["$/progress"](nil, {
			token = token,
			value = value,
		}, {
			client_id = client_id,
			method = "$/progress",
		})
	end)
end

local function run(title, cmd, client, token)
	progress(client.id, token, {
		kind = "begin",
		title = title,
		message = "Running...",
	})

	local function on_output(_, data)
		if not data then
			return
		end

		for _, line in ipairs(data) do
			line = vim.trim(line)
			if line ~= "" then
				progress(client.id, token, {
					kind = "report",
					message = line,
				})
			end
		end
	end

	vim.fn.jobstart(cmd, {
		stdout_buffered = false,
		stderr_buffered = false,

		on_stdout = on_output,
		on_stderr = on_output,

		on_exit = function(_, code)
			progress(client.id, token, {
				kind = "end",
				message = code == 0 and "Done" or ("Failed (" .. code .. ")"),
			})
		end,
	})
end

local function carton_configure(cmake_dir)
	local token = "carton-configure"
	local client = vim.lsp.get_clients({ name = "clangd" })[1]
	if not client then
		vim.notify("clangd is not active", vim.log.levels.ERROR, { title = token })
		return
	end

	if vim.fn.filereadable("carton.toml") == 1 then
		run("carton configure", { "carton" }, client, token)
	elseif cmake_dir ~= nil then
		run(
			"cmake configure",
			{ "sh", "-c", ("cmake -B %s && cmake --build %s"):format(cmake_dir, cmake_dir) },
			client,
			token
		)
	else
		vim.notify("carton.toml is missing", vim.log.levels.ERROR, { title = token })
	end
end

local settings = {
	Lua = {
		diagnostics = { globals = { "vim" } },
		workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		format = { enable = false },
	},
	python = {
		pythonPath = get_python_path(vim.fn.getcwd()),
		analysis = {
			autoSearchPaths = true,
			useLibraryCodeForTypes = true,
			diagnosticMode = "openFilesOnly",
		},
	},
	zls = {
		enable_autofix = true,
		enable_inlay_hints = true,
		warn_style = true,
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- cpp
		local cmake_dir = get_cmake_dir()
		local compile_commands_dir = get_compile_commands_dir(cmake_dir)

		if compile_commands_dir ~= nil then
			vim.lsp.config("clangd", {
				on_attach = on_attach,
				capabilities = capabilities,
				Filetypes = { "c", "cpp" },
				cmd = {
					"clangd",
					"--background-index",
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--clang-tidy=false",
					"--header-insertion=never",
					"--header-insertion-decorators=false",
					"--pch-storage=memory",
					"--limit-results=200",
					"--experimental-modules-support=false",
					"--j=8",
					"--compile-commands-dir=" .. compile_commands_dir,
				},
			})
		end

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "**/*.cppm", "carton.toml" },
			callback = function(_)
				carton_configure(cmake_dir)
			end,
		})
		vim.api.nvim_create_autocmd("BufNewFile", {
			pattern = { "**/*.cpp", "**/*.cppm", "carton.toml" },
			callback = function(_)
				carton_configure(cmake_dir)
			end,
		})

		local lsps = { "lua_ls", "gopls", "pyright", "tombi", "nginx_language_server", "dockerls" }
		local lsp_and_formatters = {
			"rust_analyzer",
			"zls",
			"buf_ls",
			"ts_ls",
			"html",
			"yamlls",
			"cssls",
			"docker_compose_language_service",
			"gitlab_ci_ls",
		}

		-- lsp only
		for _, server in ipairs(lsps) do
			vim.lsp.config(server, { on_attach = on_attach, capabilities = capabilities, settings = settings })
		end

		-- lsp + formatter
		for _, server in ipairs(lsp_and_formatters) do
			vim.lsp.config(server, {
				on_attach = function(client, bufnr)
					enable_formatter(augroup, client, bufnr)
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
				settings = settings,
			})
		end

		vim.lsp.config("neocmake", {
			cmd = { "neocmakelsp", "stdio" },
			filetypes = { "cmake" },
			root_markers = {
				"CMakePresets.json",
				"CMakeLists.txt",
				".git",
			},
			single_file_support = true, -- suggested
			on_attach = function(client, bufnr)
				enable_formatter(augroup, client, bufnr)
				on_attach(client, bufnr)
			end,
			init_options = {
				format = {
					enable = true,
				},
				lint = {
					enable = true,
				},
				scan_cmake_in_package = false, -- default is true
				line_max_words = 120,
			},
		})

		-- enable all
		local total = { "clangd", "neocmake" }
		vim.list_extend(total, lsps)
		vim.list_extend(total, lsp_and_formatters)
		for _, server in ipairs(total) do
			vim.lsp.enable(server)
		end
	end,
}
