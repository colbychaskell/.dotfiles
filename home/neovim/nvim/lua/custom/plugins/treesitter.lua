return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "bash",
      "c",
      "cpp",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "gitignore",
      "gitcommit",
      "git_config",
      "git_rebase",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
