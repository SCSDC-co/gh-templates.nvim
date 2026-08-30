local utils = require("gh-templates.utils")
local Menu = require("nui.menu")
local ui = require("gh-templates.ui")

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

---@param callback fun(template: string)
M.get_license = function(callback)
    M.get_license_name(function(licenses)
        local licenses_names = {}

        local width = #licenses[1].name

        for _, license in ipairs(licenses) do
            table.insert(licenses_names, Menu.item(license.name, { url = license.url }))

            local length = #license.name

            if length > width then
                width = length
            end
        end

        local menu = Menu(ui.create_win_options("License", width, #licenses_names), {
            lines = licenses_names,
            keymap = {
                close = { "q", "<Esc>", "<C-c>" },
            },
            on_submit = function(item)
                print(item.text .. " " .. item.url)
            end,
        })

        menu:mount()
    end)
end

return M
