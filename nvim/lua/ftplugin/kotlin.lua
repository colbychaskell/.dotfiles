-- This is for :make vim command:
-- set errorformat to BrazilGradle kotlin error output
vim.o.errorformat = [[
    %-G||%.%#,
    e: file://%f|%l| %c %m
]]
