local Menu = require("nui.menu")
local utils = require("gh-templates.utils")
local config = require("gh-templates.config")

local M = {}

---@param callback fun(templates: string[])
M.get_templates = function(callback)
    utils.make_request("https://api.github.com/gitignore/templates", callback)
end

---@param callback fun(template: string)
M.get_gitignore = function(callback)
    M.get_templates(function(templates)
        local templates_names = {}

        local _width
        local _height

        if config.license.panel.size.width ~= "auto" then
            _width = config.gitignore.panel.size.width
        else
            _width = #templates[1]
        end

        for _, template in ipairs(templates) do
            table.insert(templates_names, Menu.item(template))

            local length = #template

            if length > _width and config.gitignore.panel.size.width == "auto" then
                _width = length
            end
        end

        if config.license.panel.size.height ~= "auto" then
            _height = config.license.panel.size.height
        else
            _height = "40%"
        end

        local menu = Menu({
            relative = config.gitignore.panel.relative,
            position = config.gitignore.panel.position,

            size = {
                height = _height,
                width = _width,
            },

            border = {
                style = config.gitignore.panel.border,

                text = {
                    top = config.gitignore.panel.header,
                },
            },

            win_options = {
                winhighlight = config.winhighlight,
            },
        }, {
            lines = templates_names,
            keymap = {
                close = config.mappings.close,
                submit = config.mappings.confirm,
                focus_next = config.mappings.focus_next,
                focus_prev = config.mappings.focus_prev,
            },
            on_submit = function(item)
                callback(item.text)
            end,
        })

        menu:mount()
    end)
end

return M
