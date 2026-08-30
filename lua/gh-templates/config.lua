---@alias SizeT number | string

---@class Size
---@field width SizeT | "auto"
---@field height SizeT | "auto"

---@alias Border "bold" | "double" | "none" | "rounded" | "shadow" | "single" | "solid"

---@class PositionTable
---@field row SizeT
---@field col SizeT

---@alias Position PositionTable | SizeT

---@class RelativeWin
---@field type "win"
---@field winid integer

---@class RelativeBuffer
---@field type "buf"
---@field position Position

---@alias Relative "cursor" | "editor" | "win" | RelativeWin | RelativeBuffer

---@class Panel
---@field size Size
---@field border Border
---@field header string
---@field relative Relative
---@field position Position

---@class FeatureConf
---@field append boolean If true, append the contents if the file already exists
---@field panel Panel

---@class Keybinds
---@field close string[]
---@field confirm string[]
---@field focus_next string[]
---@field focus_prev string[]

---@class GhTemplatesOpts
---@field markers string[] File/dir names that identify the project root
---@field gitignore FeatureConf
---@field license FeatureConf
---@field winhighlight string
---@field mappings Keybinds

---@type GhTemplatesOpts
return {
    markers = { ".git" },

    gitignore = {
        append = false,

        panel = {
            size = {
                width = "auto",
                height = "auto",
            },

            header = " Gitignore Templates ",
            border = "rounded",

            relative = "editor",
            position = "50%",
        },
    },

    license = {
        append = false,

        panel = {
            size = {
                width = "auto",
                height = "auto",
            },

            header = " License ",
            border = "rounded",

            relative = "editor",
            position = "50%",
        },
    },

    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",

    mappings = {
        close = { "q", "<Esc>", "<C-c>" },
        confirm = { "<CR>" },
        focus_next = { "j", "<Down>", "<Tab>" },
        focus_prev = { "k", "<Up>", "<S-Tab>" },
    },
}
