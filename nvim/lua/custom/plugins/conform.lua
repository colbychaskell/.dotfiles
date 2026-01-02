return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, timeout_ms = 500 })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      java = { lsp_format = "first" },
      lua = { "stylua" },
      rust = { "rustfmt" },
      -- python = { "black" },
      -- kotlin = { "ktlint" },

      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },

      -- For TS/JS run ESlint as LSP first to fix linting errors
      typescript = { lsp_format = "first", "prettierd", "prettier" },
      javascript = { lsp_format = "first", "prettierd", "prettier" },
      typescriptreact = { lsp_format = "first", "prettierd", "prettier" },
      javascriptreact = { lsp_format = "first", "prettierd", "prettier" },
    },
    format_on_save = {
      -- These options will be passed to conform.format() when formatting on save
      timeout_ms = 800,
      lsp_format = "fallback",
    },
  },
}
