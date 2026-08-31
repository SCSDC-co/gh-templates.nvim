<div align=center>

# GH Templates

</div>

A simple nvim plugin for getting the .gitignores and LICENSEs templates from github.

> [!WARNING]
> This plugin is in its early stages of development, it can have bugs
> and features missing/incomplete

## Requirements

- Neovim 0.12 or newer
- `nui.nvim`

## Installation

- Using [vim.pack](https://neovim.io/doc/user/pack/#vim.pack):

```lua
vim.pack.add{
  "https://github.com/MunifTanjim/nui.nvim"
  "https://github.com/SCSDC-co/gh-templates.nvim"
}
```

- Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "SCSDC-co/gh-templates.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {}
}
```

- Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "SCSDC-co/gh-templates.nvim",
  requires = { "MunifTanjim/nui.nvim", opt = true },
}
```

- Using [vim-plug](https://github.com/junegunn/vim-plug):

```lua
Plug "MunifTanjim/nui.nvim"
Plug "SCSDC-co/gh-templates.nvim"
```

> [!CAUTION]
> Make sure to call the setup function for the plugin to work

## Configuration

This is the default configuration:

```lua
require("gh-templates").setup({
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
})
```

Check the types [here](./lua/gh-templates/config.lua)

## Usage

| Command                  | Action                       |
| ------------------------ | ---------------------------- |
| `:GhTemplates license`   | Show all license templates   |
| `:GhTemplates gitignore` | Show all gitignore templates |

## License

GNU GPL v3. See [LICENSE](LICENSE).
