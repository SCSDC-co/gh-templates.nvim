local M = {}

---@param msg string
M.info = function(msg)
    vim.notify(msg, vim.log.levels.INFO, { title = "GitHub Templates", icon = " " })
end

---@param msg string
M.error = function(msg)
    vim.notify(msg, vim.log.levels.ERROR, { title = "GitHub Templates", icon = " " })
end

return M
