local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local notify = require("gh-templates.notify")

local M = {}

---@param callback fun(templates: string[])
M.get_template = function(callback)
    vim.net.request("https://api.github.com/gitignore/templates", {}, function(err, res)
        if err then
            notify.error("An error occurred when trying to fetch the gitignore templates:\n" .. err)

            callback({})
            return
        end

        callback(vim.json.decode(res.body))
    end)
end

M.get_gitignores = function()
    M.get_template(function(templates)
        vim.print(templates)
    end)
end

return M
