local M = {}

-- helper function for checking if a table contains a value
function M.contains(table, value)
  for _, table_value in ipairs(table) do
    if table_value == value then
      return true
    end
  end

  return false
end

return M
