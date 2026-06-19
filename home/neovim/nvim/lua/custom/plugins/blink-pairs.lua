return {
  "saghen/blink.pairs",
  dependencies = "saghen/blink.lib",
  version = "0.6",
  build = function()
    require("blink.pairs").download():pwait(60000)
  end,
  opts = {},
}
