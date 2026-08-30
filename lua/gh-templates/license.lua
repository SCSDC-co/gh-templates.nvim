local utils = require("gh-templates.utils")
local Menu = require("nui.menu")
local config = require("gh-templates.config")

local M = {}

---@class LicenseType
---@field key string
---@field name string
---@field spdx_id string
---@field url string
---@field node_id string

---@param callback fun(templates: LicenseType[])
M.get_license_name = function(callback)
    utils.make_request("https://api.github.com/licenses", callback)
end

---@param callback fun(url: string)
M.get_license = function(callback)
    M.get_license_name(function(licenses)
        local licenses_names = {}

        local _width
        local _height

        if config.license.panel.size.width ~= "auto" then
            _width = config.license.panel.size.width
        else
            _width = #licenses[1].name
        end

        for _, license in ipairs(licenses) do
            table.insert(licenses_names, Menu.item(license.name, { url = license.url }))

            local length = #license.name

            if length > _width and config.license.panel.size.width == "auto" then
                _width = length
            end
        end

        if config.license.panel.size.height ~= "auto" then
            _height = config.license.panel.size.height
        else
            _height = #licenses_names
        end

        local menu = Menu({
            relative = config.license.panel.relative,
            position = config.license.panel.position,

            size = {
                height = _height,
                width = _width,
            },

            border = {
                style = config.license.panel.border,

                text = {
                    top = config.license.panel.header,
                },
            },

            win_options = {
                winhighlight = config.winhighlight,
            },
        }, {
            lines = licenses_names,
            keymap = {
                close = config.mappings.close,
                submit = config.mappings.confirm,
                focus_next = config.mappings.focus_next,
                focus_prev = config.mappings.focus_prev,
            },
            on_submit = function(item)
                callback(item.url)
            end,
        })

        menu:mount()
    end)
end

return M
