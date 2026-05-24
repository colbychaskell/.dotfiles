return {
  "ThePrimeagen/refactoring.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Set key bind for refactoring selector
    vim.keymap.set({ "n", "x" }, "<leader>rr", function()
      require("refactoring").select_refactor()
    end)
  end,
}
