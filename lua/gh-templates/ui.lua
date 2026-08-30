local M = {}

---@return table
---@param text string
M.create_win_options = function(text)
    local width = string.len(text) + 4
    local border_text = {
        top = " " .. text .. " ",
        top_align = "center",
    }

    return {
        relative = "editor",
        position = "50%",
        size = width,
        border = {
            style = "rounded",
            text = border_text,
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
    }
end

return M
