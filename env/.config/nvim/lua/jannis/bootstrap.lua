local M = {}

function M.lazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		if vim.fn.executable("git") ~= 1 then
			error("lazy.nvim is missing and git is not installed. Install git and restart Neovim.")
		end

		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

return M
