return {
  { "aklt/plantuml-syntax" },
  {
    "https://gitlab.com/itaranto/preview.nvim",
    version = "*",
    opts = {
      previewers_by_ft = {
        plantuml = {
          name = "plantuml_png",
          renderer = { type = "buffer", opts = { split_cmd = "split" } },
        },
      },
    },
  },
}
