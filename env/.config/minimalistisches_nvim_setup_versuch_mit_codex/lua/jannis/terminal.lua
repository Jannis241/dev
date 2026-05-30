local M = {}

local function shellescape(value)
	return vim.fn.shellescape(value)
end

local function tmpbin(name)
	return shellescape(vim.fn.stdpath("cache") .. "/run-" .. name)
end

local function current_file()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("No file to run", vim.log.levels.WARN)
		return nil
	end
	return file
end

local function project_root(markers)
	return vim.fs.root(0, markers)
end

function M.open(cmd)
	vim.cmd("botright 12split")
	vim.cmd("enew")
	vim.fn.termopen(cmd and cmd ~= "" and cmd or vim.o.shell)
	vim.cmd("startinsert")
end

function M.run_file()
	local file = current_file()
	if not file then
		return
	end

	local ft = vim.bo.filetype
	local quoted = shellescape(file)
	local stem = vim.fn.fnamemodify(file, ":t:r")
	local cmd

	if ft == "python" then
		cmd = "python3 " .. quoted
	elseif ft == "sh" or ft == "bash" then
		cmd = "bash " .. quoted
	elseif ft == "zsh" then
		cmd = "zsh " .. quoted
	elseif ft == "lua" then
		cmd = "lua " .. quoted
	elseif ft == "c" then
		local out = tmpbin(stem)
		cmd = "cc " .. quoted .. " -o " .. out .. " && " .. out
	elseif ft == "cpp" then
		local out = tmpbin(stem)
		cmd = "c++ " .. quoted .. " -o " .. out .. " && " .. out
	elseif ft == "rust" then
		local root = project_root({ "Cargo.toml" })
		if root then
			cmd = "cd " .. shellescape(root) .. " && cargo run"
		else
			local out = tmpbin(stem)
			cmd = "rustc " .. quoted .. " -o " .. out .. " && " .. out
		end
	elseif ft == "java" then
		local out_dir = shellescape(vim.fn.stdpath("cache") .. "/java-run")
		cmd = "mkdir -p " .. out_dir .. " && javac -d " .. out_dir .. " " .. quoted .. " && java -cp " .. out_dir .. " " .. stem
	end

	if not cmd then
		vim.notify("No runner configured for filetype: " .. ft, vim.log.levels.WARN)
		return
	end

	M.open(cmd)
end

function M.setup()
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Leave terminal mode" })
	vim.keymap.set("n", "<leader>tt", function()
		M.open()
	end, { desc = "Open terminal" })
	vim.keymap.set("n", "<leader>tr", M.run_file, { desc = "Run current file" })

	vim.api.nvim_create_user_command("Term", function(opts)
		M.open(opts.args)
	end, {
		nargs = "*",
		complete = "shellcmd",
		desc = "Open terminal split",
	})

	vim.api.nvim_create_user_command("Run", function(opts)
		M.open(opts.args)
	end, {
		nargs = "+",
		complete = "shellcmd",
		desc = "Run shell command in terminal split",
	})

	vim.api.nvim_create_user_command("RunFile", M.run_file, {
		desc = "Run current file",
	})
end

return M
