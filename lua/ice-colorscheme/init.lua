local Config = require("ice-colorscheme.config").Config
local utils = require "ice-colorscheme.utils"

local M = {}

---@param opts Config
M.setup = function(opts)
    opts = vim.tbl_deep_extend("keep", opts, Config:default())

    M.set_colorscheme = function(name)
        require("ice-colorscheme.colorscheme").set_colorscheme(name, opts)
    end

    M.select_colorscheme = function()
        require("ice-colorscheme.telescope").select_colorscheme(opts)
    end

    if opts.lasting_change then
        local colorscheme = utils.read(opts.colorscheme_cache)
        if colorscheme ~= nil then
            M.set_colorscheme(colorscheme)
        end
    elseif opts.colorscheme ~= nil then
        M.set_colorscheme(opts.colorscheme)
    end
end

-- Sets the colorscheme; will be overridden once setup is called
---@param name string The name of the colorscheme; must be specified in config table
---@diagnostic disable-next-line: unused-local
M.set_colorscheme = function(name) end

-- Selects a colorscheme from various alternatives
M.select_colorscheme = function() end

return M
