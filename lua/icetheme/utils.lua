local M = {}

-- Notify an error
---@param msg string The error message to display
M.error = function(msg)
    vim.notify("[Icetheme] " .. msg, vim.log.levels.ERROR)
end

-- Allow ordered iteration through a table
---@param t table
---@return function
M.ordered_pair = function(t)
    local a = {}
    for n in pairs(t) do
        a[#a + 1] = n
    end
    table.sort(a)

    local i = 0
    return function()
        i = i + 1
        return a[i], t[a[i]]
    end
end

return M
