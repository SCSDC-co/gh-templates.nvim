local gitignore = require("gh-templates.gitignore")

local M = {}

M.gitignore = function()
    gitignore.get_gitignore()
end

M.setup = function() end

return M
