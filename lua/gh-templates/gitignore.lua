local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local notify = require("gh-templates.notify")

local M = {}

M.get_template = function()
    vim.net.request("https://api.github.com/gitignore/templates", {}, function(err, res)
        if err then
            notify.error("An error occoured when trying to fetch the gitignore templates:\n" .. err)

            return
        end

        ---@type string[]
        local templates = vim.json.decode(res.body)

        print(templates)
    end)
end

M.get_gitignores = function()
    M.get_template()
end

return M
