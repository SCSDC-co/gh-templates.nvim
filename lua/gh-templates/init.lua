local gitignore = require("gh-templates.gitignore")
local utils = require("gh-templates.utils")

local M = {}

M.gitignore = function()
    gitignore.get_gitignore(function(template)
        utils.make_request(
            "https://api.github.com/gitignore/templates/" .. template,
            function(gitignore)
                vim.print(gitignore.name)
                vim.print(gitignore.source)
            end
        )
    end)
end

M.setup = function() end

return M
