local M = {}

---@return table
---@param text string
---@param _width? integer
---@param _height? integer
M.create_win_options = function(text, _width, _height)
    local width = _width or string.len(text) + 4
    local height = _height or "40%"
    local border_text = {
        top = " " .. text .. " ",
        top_align = "center",
    }

    return {
        relative = "editor",
        position = "50%",
        size = {
            width = width,
            height = height,
        },
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
