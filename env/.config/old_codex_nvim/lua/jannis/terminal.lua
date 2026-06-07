local M = {}

local state = {
	buf = nil,
	win = nil,
	job = nil,
}

local function dimensions()
	local width = math.floor(vim.o.columns * 0.85)
	local height = math.floor(vim.o.lines * 0.75)

	return {
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
	}
end

local function open_window(buf)
	local size = dimensions()

	state.win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = size.width,
		height = size.height,
		row = size.row,
		col = size.col,
		style = "minimal",
		border = "rounded",
		title = " Terminal ",
		title_pos = "center",
	})
end

local function enter_terminal_mode()
	vim.schedule(function()
		if state.win and vim.api.nvim_win_is_valid(state.win) then
			vim.api.nvim_set_current_win(state.win)
			vim.cmd.startinsert()
		end
	end)
end

local function stop_job()
	if state.job then
		local job = state.job
		state.job = nil

		pcall(vim.fn.chansend, job, "exit\n")
		pcall(vim.fn.jobstop, job)
		pcall(vim.fn.jobwait, { job }, 200)
	end
end

function M.cleanup()
	stop_job()

	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end

	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		vim.api.nvim_buf_delete(state.buf, { force = true })
	end

	state.buf = nil
	state.win = nil
end

function M.toggle()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		M.cleanup()
		return
	end

	if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) or not state.job then
		state.buf = vim.api.nvim_create_buf(false, false)
		vim.bo[state.buf].bufhidden = "wipe"
		open_window(state.buf)
		state.job = vim.fn.termopen(vim.o.shell, {
			on_exit = function()
				state.job = nil
			end,
		})
		enter_terminal_mode()
		return
	end

	open_window(state.buf)
	enter_terminal_mode()
end

function M.setup()
	vim.api.nvim_create_user_command("Term", M.toggle, {})
	vim.api.nvim_create_user_command("TermToggle", M.toggle, {})
	vim.cmd([[cnoreabbrev <expr> term getcmdtype() == ':' && getcmdline() ==# 'term' ? 'Term' : 'term']])
	vim.keymap.set("n", "<leader>tt", M.toggle, { desc = "Toggle terminal" })
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })

	vim.api.nvim_create_autocmd({ "QuitPre", "VimLeavePre" }, {
		group = vim.api.nvim_create_augroup("jannis_terminal", { clear = true }),
		callback = M.cleanup,
	})
end

return M
