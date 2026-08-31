local gitignore = require("gh-templates.gitignore")
local license = require("gh-templates.license")
local utils = require("gh-templates.utils")
local config = require("gh-templates.config")
local notify = require("gh-templates.notify")

local M = {}

M.gitignore = function()
    gitignore.get_gitignore(function(template)
        utils.make_request(
            "https://api.github.com/gitignore/templates/" .. template,
            function(gitignore_response)
                utils.write_to_file(
                    M.gitignore_file,
                    gitignore_response.source,
                    M.opts.gitignore.append
                )

                notify.info(
                    "Template '" .. gitignore_response.name .. "' saved to " .. M.gitignore_file
                )
            end
        )
    end, M.opts)
end

M.license = function()
    license.get_license(function(url)
        ---@param _license LicenseResponse
        utils.make_request(url, function(_license)
            utils.write_to_file(M.license_file, _license.body, M.opts.license.append)

            notify.info("Template '" .. _license.name .. "' saved to " .. M.license_file)
        end)
    end, M.opts)
end

M.setup = function(opts)
    M.opts = vim.tbl_deep_extend("force", config, opts or {})

    M.project_root = utils.find_project_root(M.opts.markers)

    if M.project_root == nil then
        notify.error("Failed to get the project root, saving the files to the current cwd")

        M.project_root = vim.fn.getcwd()
    end

    M.gitignore_file = vim.fs.joinpath(M.project_root, ".gitignore")
    M.license_file = vim.fs.joinpath(M.project_root, "LICENSE")
end

return M
