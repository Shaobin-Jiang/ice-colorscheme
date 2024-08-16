local M = {}

---@class Colorscheme
---@field name string The name of the colorscheme, one which you would use for neovim's `colorscheme` command
---@field dark boolean Whether `vim.o.background` should be set to `dark`
---@field setup table | nil | fun():table | fun():nil Setup for the colorscheme
M.Colorscheme = {}

return M
