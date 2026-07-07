vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

if vim.fn.executable("jdtls") ~= 1 then
  return
end

local root_dir = require("jdtls.setup").find_root({ "build.gradle", "build.gradle.kts", "pom.xml", ".git", "Config" })
local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":t")

local config = {
  cmd = {
    "jdtls",
    "-data",
    vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name,
  },
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {},
      },
    },
  },
}

local has_bemol, bemol = pcall(require, "extra.utils.bemol")
if has_bemol then
  local bemol_dir = bemol.get_bemol_root()
  if bemol_dir then
    local ws_folders = bemol.get_bemol_package_roots(bemol_dir)
    if #ws_folders > 0 then
      config.workspace_folders = {}
      for _, folder in ipairs(ws_folders) do
        table.insert(config.workspace_folders, { uri = vim.uri_from_fname(folder), name = vim.fn.fnamemodify(folder, ":t") })
      end
    end
  end
end

require("jdtls").start_or_attach(config)
