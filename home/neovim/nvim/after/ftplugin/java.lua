vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local java_21 = "/usr/lib/jvm/java-21-amazon-corretto/bin/java"

if vim.fn.executable(java_21) == 1 and vim.fn.isdirectory(jdtls_path) == 1 then
  local lombok_jar = jdtls_path .. "/lombok.jar"
  local root_dir = require("jdtls.setup").find_root({ "build.gradle", "build.gradle.kts", "pom.xml", ".git", "Config" })
  local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":t")

  local cmd = {
    java_21,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    jdtls_path .. "/config_linux",
    "-data",
    vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name,
  }

  if vim.uv.fs_stat(lombok_jar) then
    table.insert(cmd, 2, "-javaagent:" .. lombok_jar)
  end

  local config = {
    cmd = cmd,
    root_dir = root_dir,
    settings = {
      java = {
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {},
        },
        configuration = {
          runtimes = {
            { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-amazon-corretto.x86_64" },
            { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-amazon-corretto.x86_64" },
            { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-amazon-corretto" },
          },
        },
      },
    },
  }

  -- Add bemol workspace folders if available
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
end
