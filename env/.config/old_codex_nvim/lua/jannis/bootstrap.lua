local M = {}

function M.lazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	local uv = vim.uv or vim.loop
	if not uv.fs_stat(lazypath) then
		if vim.fn.executable("git") ~= 1 then
			error("lazy.nvim is missing and git is not installed. Install git and restart Neovim.")
		end

		local result = vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
		if vim.v.shell_error ~= 0 then
			error("lazy.nvim could not be installed:\n" .. result)
		end
	end
	vim.opt.rtp:prepend(lazypath)
end

return M
