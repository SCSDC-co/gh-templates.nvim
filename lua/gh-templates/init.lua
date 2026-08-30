local gitignore = require("gh-templates.gitignore")

local M = {}

M.gitignore = function()
    gitignore.get_template(function(templates)
        vim.print(templates)
    end)
end

M.setup = function() end

return M
