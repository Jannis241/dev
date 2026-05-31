local M = {}

local uv = vim.uv or vim.loop

local function executable_any(names)
	for _, name in ipairs(names) do
		if vim.fn.executable(name) == 1 then
			return true, name
		end
	end
	return false, nil
end

local function mkdir(path)
	if path and path ~= "" then
		vim.fn.mkdir(path, "p")
	end
end

local function has_usable_shell()
	return vim.o.shell ~= "" and vim.fn.executable(vim.o.shell) == 1
end

local requirements = {
	{
		name = "git",
		commands = { "git" },
		required = true,
		reason = "required to bootstrap lazy.nvim and install plugins",
	},
	{
		name = "curl",
		commands = { "curl" },
		required = true,
		reason = "used by Mason and many language/tool installers",
	},
	{
		name = "unzip",
		commands = { "unzip" },
		required = true,
		reason = "used by Mason to unpack downloaded tools",
	},
	{
		name = "tar",
		commands = { "tar" },
		required = true,
		reason = "used by Mason and plugin/tool archives",
	},
	{
		name = "make",
		commands = { "make" },
		required = true,
		reason = "required for native plugins such as telescope-fzf-native",
	},
	{
		name = "C compiler",
		commands = { "cc", "clang", "gcc" },
		required = true,
		reason = "required to build Treesitter parsers and native plugins",
	},
	{
		name = "ripgrep",
		commands = { "rg" },
		required = false,
		reason = "required for Telescope live_grep",
	},
	{
		name = "Java",
		commands = { "java" },
		required = false,
		reason = "required for jdtls and Java formatting",
	},
	{
		name = "Rust toolchain",
		commands = { "cargo" },
		required = false,
		reason = "required for normal Rust project workflows",
	},
	{
		name = "rustfmt",
		commands = { "rustfmt" },
		required = false,
		reason = "required for Rust format-on-save",
	},
	{
		name = "Node.js",
		commands = { "node" },
		required = false,
		reason = "used by some Mason language servers and tooling",
	},
	{
		name = "Python 3",
		commands = { "python3", "python" },
		required = false,
		reason = "useful for Python tooling outside Mason",
	},
}

function M.undo_dir()
	local home = vim.env.HOME
	if not home or home == "" then
		return vim.fn.stdpath("state") .. "/undo"
	end
	return home .. "/.vim/undodir"
end

function M.ensure_directories()
	mkdir(M.undo_dir())
end

function M.can_build_native()
	local has_make = vim.fn.executable("make") == 1
	local has_compiler = executable_any({ "cc", "clang", "gcc" })
	return has_make and has_compiler
end

function M.check()
	local results = {}

	for _, requirement in ipairs(requirements) do
		local ok, command = executable_any(requirement.commands)
		table.insert(results, {
			ok = ok,
			name = requirement.name,
			command = command,
			required = requirement.required,
			reason = requirement.reason,
		})
	end

	local undo_dir = M.undo_dir()
	table.insert(results, {
		ok = undo_dir ~= nil and uv.fs_stat(undo_dir) ~= nil,
		name = "undo directory",
		command = undo_dir,
		required = false,
		reason = "required for persistent undo files",
	})

	table.insert(results, {
		ok = has_usable_shell(),
		name = "shell",
		command = vim.o.shell,
		required = true,
		reason = "required for :terminal and shell commands",
	})

	return results
end

function M.missing()
	local missing = {}
	for _, result in ipairs(M.check()) do
		if not result.ok then
			table.insert(missing, result)
		end
	end
	return missing
end

function M.report()
	local lines = {}
	for _, result in ipairs(M.check()) do
		local status = result.ok and "OK" or (result.required and "MISSING" or "OPTIONAL")
		local command = result.command and (" (" .. result.command .. ")") or ""
		table.insert(lines, string.format("%-8s %s%s - %s", status, result.name, command, result.reason))
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Neovim requirements" })
end

function M.setup()
	M.ensure_directories()

	vim.api.nvim_create_user_command("Requirements", M.report, {
		desc = "Show external requirements for this Neovim config",
	})

	vim.schedule(function()
		local missing_required = {}
		for _, result in ipairs(M.missing()) do
			if result.required then
				table.insert(missing_required, result.name)
			end
		end

		if #missing_required > 0 then
			vim.notify(
				"Missing required tools: " .. table.concat(missing_required, ", ") .. "\nRun :Requirements for details.",
				vim.log.levels.WARN,
				{ title = "Neovim requirements" }
			)
		end
	end)
end

return M
