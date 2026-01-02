return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local colors = require("tokyonight.colors").setup()
    -- local copilot_colors = {
    --   [""] = { fg = colors.grey, bg = colors.none },
    --   ["Normal"] = { fg = colors.grey, bg = colors.none },
    --   ["Warning"] = { fg = colors.red, bg = colors.none },
    --   ["InProgress"] = { fg = colors.yellow, bg = colors.none },
    -- }
    return {
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        theme = "tokyonight",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰝶 ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
          -- TODO: Test this. It adds LSP context for where you are in the code
          --
          -- {
          --   function()
          --     return require("nvim-navic").get_location()
          --   end,
          --   cond = function()
          --     return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          --   end,
          --   color = { fg = colors.grey, bg = colors.none },
          -- },
        },
        lualine_x = {
          Snacks.profiler.status(),
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = colors.green },
          },
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return { fg = Snacks.util.color("Debug") }
            end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },
          {
            "diff",
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          -- TODO: Add Amazon Q indicator
          -- {
          --   function()
          --     local icon = " "
          --     -- local status = require("copilot.api").status.data
          --     local status
          --     return icon .. (status.message or "")
          --   end,
          --   cond = function()
          --     local ok, clients = pcall(vim.lsp.get_clients, { name = "amazonq", bufnr = 0 })
          --     return ok and #clients > 0
          --   end,
          --   color = function()
          --     if not package.loaded["amazonq"] then
          --       return
          --     end
          --     -- local status = require("copilot.api").status.data
          --     -- return copilot_colors[status.status] or copilot_colors[""]
          --   end,
          -- },
          { "diff" },
        },
        lualine_y = {
          {
            "progress",
          },
          {
            "location",
            color = { fg = colors.cyan },
          },
        },
        lualine_z = {
          function()
            return "  " .. os.date("%X") .. " 🚀 "
          end,
        },
      },

      extensions = { "lazy", "toggleterm", "mason", "neo-tree", "trouble" },
    }
  end,
}
