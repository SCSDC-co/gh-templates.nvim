local gh_templates = require("gh-templates")

vim.api.nvim_create_user_command("GhTemplates", function(opts)
    if opts.args == "gitignore" then
        gh_templates.gitignore()
    end
end, {
    nargs = 1,

    complete = function(ArgLead, CmdLine, CursorPos)
        return { "gitignore" }
    end,
})
