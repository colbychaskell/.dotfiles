-- Highlight todo, notes, etc in comments
--
-- You can configure highlights by doing something like:
-- vim.cmd.hi 'Comment gui=none'
return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = false },
}
