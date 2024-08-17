local global = require "ice-colorscheme.global"
local utils = require "ice-colorscheme.utils"

local M = {}

-- Checks whether telescope is installed
---@return boolean
local function check_telescope()
    local status, _ = pcall(require, "telescope")
    if not status then
        utils.error "telescope is not installed!"
    end
    return status
end

-- Picker for telescope
---@param config Config
local function picker(config)
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    local opts = {}

    ---@type table<string, Colorscheme>
    local colorschemes = config.colorschemes

    local results = { global.get_current_colorscheme() }
    for name, _ in utils.ordered_pair(colorschemes) do
        if name ~= global.get_current_colorscheme() then
            results[#results + 1] = name
        end
    end

    pickers
        .new(opts, {
            prompt_title = config.prompt_title,
            finder = finders.new_table {
                entry_maker = function(colorscheme)
                    local entry = colorscheme
                    if colorscheme == global.get_current_colorscheme() then
                        entry = entry .. config.suffix_current
                    end

                    return {
                        value = colorscheme,
                        display = entry,
                        ordinal = entry,
                    }
                end,
                results = results,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    require("ice-colorscheme").set_colorscheme(action_state.get_selected_entry().value)
                end)
                return true
            end,
        })
        :find()
end

---@param opts Config
M.select_colorscheme = function(opts)
    if not check_telescope() then
        return
    end

    picker(opts)
end

return M
