vim.cmd.colorscheme "catppuccin-macchiato"

require("catppuccin").setup({
    transparent_background = true, -- disables setting the background color.
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    }
})
