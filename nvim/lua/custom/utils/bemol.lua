local tbl = require("custom.utils.table")
-- local notify = require("custom.utils.notify")

local M = {}

function M.get_bemol_root()
  local dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
  if not dir then
    -- notify.warn("Bemol root not found")
    return
  end

  return dir
end

function M.get_bemol_package_roots(bemol_dir)
  if not bemol_dir then
    return {}
  end

  local file = io.open(bemol_dir .. "/ws_root_folders", "r")
  if not file then
    -- notify.warn("ws_root_folders not found in bemol root")
    return {}
  end

  local roots = {}
  for line in file:lines() do
    table.insert(roots, line)
  end
  file:close()

  return roots
end

-- gathers all of the bemol-generated files and adds them to the LSP workspace
function M.lsp_config()
  local bemol_dir = M.get_bemol_root()

  if not bemol_dir then
    return
  end

  -- Get list of bemol workspace package roots
  local ws_folders_lsp = M.get_bemol_package_roots(bemol_dir)

  -- Add each bemol package root to the LSP workspace folders
  for _, line in ipairs(ws_folders_lsp) do
    if not tbl.contains(vim.lsp.buf.list_workspace_folders(), line) then
      vim.lsp.buf.add_workspace_folder(line)
    end
  end
end

return M
