local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local notify = require("gh-templates.notify")
local ui = require("gh-templates.ui")

local M = {}

---@param callback fun(templates: string[] | string)
---@param url string
M.make_request = function(url, callback)
    vim.net.request(url, {}, function(err, res)
        if err then
            notify.error("An error occurred:\n" .. err)

            callback({})
            return
        end

        callback(vim.json.decode(res.body))
    end)
end

---@param callback fun(templates: string[])
M.get_templates = function(callback)
    M.make_request("https://api.github.com/gitignore/templates", callback)
end

M.get_gitignore = function()
    M.get_templates(function(templates)
        local templates_names = {}

        for _, template in ipairs(templates) do
            table.insert(templates_names, Menu.item(template))
        end

        local menu = Menu(ui.create_win_options("Gitignore Templates"), {
            lines = templates_names,
        })

        menu:mount()
    end)
end

return M
