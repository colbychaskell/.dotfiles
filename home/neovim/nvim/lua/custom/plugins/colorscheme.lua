-- Neovim theme
return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background_level = 1,
      background = "medium", -- Options: "soft", "medium", "hard"
      italics = true,
    },
    config = function(_, opts)
      require("everforest").setup(opts)
      require("everforest").load()
    end,
  },
}

-- TokyoNight config
--
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     style = "storm",
--     transparent = true,
--     styles = {
--       sidebars = "transparent",
--       floats = "transparent",
--     },
--   },
--   config = function(_, opts)
--     local tokyonight = require("tokyonight")
--     tokyonight.setup(opts)
--     tokyonight.load()
--   end,
-- }
