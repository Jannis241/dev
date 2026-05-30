require("jannis.bootstrap").lazy()
require("jannis.set")
require("jannis.lsp")

require("lazy").setup("jannis.plugins", {
	install = {
		missing = true,
	},
	checker = {
		enabled = false,
	},
	change_detection = {
		notify = false,
	},
})

require("jannis.theme").setup()
require("jannis.terminal").setup()
require("jannis.remap")

