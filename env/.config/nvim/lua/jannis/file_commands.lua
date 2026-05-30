local uv = vim.uv or vim.loop

local M = {}

local function fail(message)
	vim.notify(message, vim.log.levels.ERROR, { title = "File command" })
end

local function refresh_tree()
	if package.loaded["neo-tree.sources.manager"] then
		pcall(vim.cmd, "Neotree refresh")
	end
end

local function normalize(path)
	return vim.fn.fnamemodify(path, ":p")
end

local function basename(path)
	return vim.fn.fnamemodify(path, ":t")
end

local function destination_for(source, destination, multiple_sources)
	if vim.fn.isdirectory(destination) == 1 then
		return normalize(destination .. "/" .. basename(source))
	end

	if multiple_sources then
		return nil, "Destination must be an existing directory for multiple sources"
	end

	return normalize(destination)
end

function M.touch(opts)
	for _, path in ipairs(opts.fargs) do
		local full_path = normalize(path)
		local fd, open_err = uv.fs_open(full_path, "a", 420)

		if not fd then
			fail(("Could not touch %s: %s"):format(path, open_err or "unknown error"))
			return
		end

		uv.fs_close(fd)
		uv.fs_utime(full_path, os.time(), os.time())
	end

	refresh_tree()
end

function M.mkdir(opts)
	for _, path in ipairs(opts.fargs) do
		local ok = vim.fn.mkdir(path, "p")
		if ok == 0 then
			fail("Could not create directory: " .. path)
			return
		end
	end

	refresh_tree()
end

function M.move(opts)
	if #opts.fargs < 2 then
		fail("Usage: :mv source destination")
		return
	end

	local destination = table.remove(opts.fargs)
	local multiple_sources = #opts.fargs > 1

	for _, source in ipairs(opts.fargs) do
		local target, err = destination_for(source, destination, multiple_sources)
		if not target then
			fail(err)
			return
		end

		local ok, rename_err = uv.fs_rename(normalize(source), target)
		if not ok then
			fail(("Could not move %s: %s"):format(source, rename_err or "unknown error"))
			return
		end
	end

	refresh_tree()
end

function M.copy(opts)
	if #opts.fargs < 2 then
		fail("Usage: :cp source destination")
		return
	end

	local destination = table.remove(opts.fargs)
	local multiple_sources = #opts.fargs > 1

	for _, source in ipairs(opts.fargs) do
		local target, err = destination_for(source, destination, multiple_sources)
		if not target then
			fail(err)
			return
		end

		local ok, copy_err = uv.fs_copyfile(normalize(source), target)
		if not ok then
			fail(("Could not copy %s: %s"):format(source, copy_err or "unknown error"))
			return
		end
	end

	refresh_tree()
end

local function abbreviate(from, to)
	vim.cmd(
		("cnoreabbrev <expr> %s getcmdtype() == ':' && getcmdline() ==# '%s' ? '%s' : '%s'"):format(
			from,
			from,
			to,
			from
		)
	)
end

function M.setup()
	vim.api.nvim_create_user_command("Touch", M.touch, { nargs = "+", complete = "file" })
	vim.api.nvim_create_user_command("Mkdir", M.mkdir, { nargs = "+", complete = "dir" })
	vim.api.nvim_create_user_command("Mv", M.move, { nargs = "+", complete = "file" })
	vim.api.nvim_create_user_command("Cp", M.copy, { nargs = "+", complete = "file" })

	abbreviate("touch", "Touch")
	abbreviate("mkdir", "Mkdir")
	abbreviate("mv", "Mv")
	abbreviate("cp", "Cp")
end

return M
