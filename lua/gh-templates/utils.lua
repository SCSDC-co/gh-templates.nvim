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

---@param markers string[] File/dir names that identify the root
---@return string? root The path of the found root directory, or nil if not found
M.find_project_root = function(markers)
    local found = vim.fs.find(markers, {
        upward = true,
        path = vim.fn.getcwd(),
    })[1]

    if not found then
        return nil
    end

    return vim.fs.dirname(found)
end

---@param path string where to save the file
---@param content string the content of the file
M.write_to_file = function(path, content)
    vim.fn.writefile(content, path)
end

return M
