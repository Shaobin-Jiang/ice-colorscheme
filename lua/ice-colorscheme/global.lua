local M = {}

---@type string
vim.g.ice_colorscheme_current = ""

M.get_current_colorscheme = function()
    return vim.g.ice_colorscheme_current
end

---@param colorscheme string
M.set_current_colorscheme = function(colorscheme)
    vim.g.ice_colorscheme_current = colorscheme
end

return M
