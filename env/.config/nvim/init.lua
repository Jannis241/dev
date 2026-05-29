-- für c => damit bei .h files nicht c++ erkannt wird
vim.filetype.add({
  extension = {
    h = "c",
  },
})
require("jannis")
