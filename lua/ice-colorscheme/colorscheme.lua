local global = require "ice-colorscheme.global"
local utils = require "ice-colorscheme.utils"

local M = {}

---@class Colorscheme
---@field name string The name of the colorscheme, one which you would use for neovim's `colorscheme` command
---@field dark boolean Whether `vim.o.background` should be set to `dark`
---@field setup table | nil | fun():nil Setup for the colorscheme
M.Colorscheme = {}

---@param name string The name of the colorscheme
---@param opts Config Config table
M.set_colorscheme = function(name, opts)
    ---@type Colorscheme
    local colorscheme = opts.colorschemes[name]
    if colorscheme == nil or type(colorscheme) ~= "table" then
        utils.error("colorscheme " .. name .. " is not specified in setup!")
        return
    end

    if type(colorscheme.setup) == "table" then
        require(colorscheme.name).setup(colorscheme.setup)
    elseif type(colorscheme.setup) == "function" then
        colorscheme.setup()
    end

    vim.api.nvim_command("colorscheme " .. colorscheme.name)

    if colorscheme.dark then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end

    vim.api.nvim_set_hl(0, "Visual", { reverse = true })

    global.set_current_colorscheme(name)

    if type(opts.setup) == "function" then
        opts.setup(name, colorscheme)
    end

    if opts.lasting_change then
        utils.write(opts.colorscheme_cache, name)
    end
end

return M
