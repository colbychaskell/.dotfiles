local M = {}

-- helper function for finding a filename in a directory which matches
-- the specified pattern
function M.find(directory, pattern)
  local filename_found = ""
  local pfile = io.popen('ls "' .. directory .. '"')

  if pfile == nil then
    return ""
  end

  for filename in pfile:lines() do
    if string.find(filename, pattern) ~= nil then
      filename_found = filename
      break
    end
  end

  return filename_found
end

return M
