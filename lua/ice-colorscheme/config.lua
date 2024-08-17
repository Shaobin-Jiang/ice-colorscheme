local M = {}

---@class Config
---@field colorschemes table<string, Colorscheme> All colorschemes to include in the colorscheme selector
---@field setup nil | fun(name: string, setup: Colorscheme | nil):nil A global setup function to be run for all colorschemes
---@field colorscheme string | nil The colorscheme to use upon startup; defaults to `nil`
---@field lasting_change boolean Whether the change made in the selector should be lasting; defaults to `true`
---@field colorscheme_cache string Path to the file where the colorscheme used in the last session is stored
---@field suffix_current string Content after a colorscheme to mark that it is currently being used
---@field prompt_title string Title of the selector window
M.Config = {}

-- Creates a default config object
function M.Config:default()
    setmetatable({}, self)
    self.__index = self

    self.colorschemes = {}
    self.setup = nil
    self.colorscheme = nil
    self.lasting_change = true
    self.colorscheme_cache = vim.fn.stdpath "data" .. "/colorscheme"
    self.suffix_current = " (Current)"
    self.prompt_title = "Colorschemes"

    return self
end

return M
