local M = {}

M.config_tbl = {
  enable_deceleration = false,
  acceleration_limit = 160,
  acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
  deceleration_table = { { 150, 9999 } },
}

local config = M.config_tbl
local driver = require('csj.core.accelerated-jk.time_driven'):new(config)

function M.move_to(movement) driver:move_to(movement) end

function M.reset_key_count() driver:reset_key_count() end

vim.keymap.set('n', 'j', function() require('csj.core.accelerated-jk').move_to('j') end)
vim.keymap.set('n', 'k', function() require('csj.core.accelerated-jk').move_to('k') end)

return M
