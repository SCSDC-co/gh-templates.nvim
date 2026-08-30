local notify = require("gh-templates.notify")

local M = {}

---@class TemplateResponse
---@field name string
---@field source string

---@param url string
---@param callback fun(templates: string[] | TemplateResponse)
M.make_request = function(url, callback)
    vim.net.request(url, {}, function(err, res)
        vim.schedule(function()
            if err then
                notify.error("An error occurred:\n" .. err)

                return
            end

            callback(vim.json.decode(res.body))
        end)
    end)
end

return M
