local Menu = require("nui.menu")
local ui = require("gh-templates.ui")
local utils = require("gh-templates.utils")

local M = {}

---@param callback fun(templates: string[])
M.get_templates = function(callback)
    utils.make_request("https://api.github.com/gitignore/templates", callback)
end

---@param callback fun(template: string)
M.get_gitignore = function(callback)
    M.get_templates(function(templates)
        local templates_names = {}

        for _, template in ipairs(templates) do
            table.insert(templates_names, Menu.item(template))
        end

        local menu = Menu(ui.create_win_options("Gitignore Templates"), {
            lines = templates_names,
            keymap = {
                close = { "q", "<Esc>", "<C-c>" },
            },
            on_submit = function(item)
                callback(item.text)
            end,
        })

        menu:mount()
    end)
end

return M
