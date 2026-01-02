local M = {}

function M.warn(message)
  M.notify(message, vim.log.levels.WARN)
end

function M.debug(message)
  M.notify(message, vim.log.levels.DEBUG)
end

function M.notify(message, level)
  local logLevel = vim.g.custom_log_level

  if logLevel == nil then
    logLevel = vim.log.levels.OFF
  end

  if level >= vim.g.custom_log_level then
    vim.notify(message, level)
  end
end

return M
