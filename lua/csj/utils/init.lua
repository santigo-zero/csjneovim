local utils = {}

-- Disable things I'm not going to use, this include builtin plugins, providers,
-- filetype.vim and the shada file.
function utils.disable()
  -- Plugins
  vim.g.loadplugins = false
  vim.g.did_indent_on = 1
  vim.g.did_load_ftplugin = 1

  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_bugreport = 1
  vim.g.loaded_compiler = 1
  vim.g.loaded_ftplugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_gzip = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_logipat = 1
  vim.g.loaded_man = 1
  vim.g.loaded_matchParen = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_optwin = 1
  vim.g.loaded_perl_provider = 1
  vim.g.loaded_rplugin = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_spec = 1
  vim.g.loaded_synmenu = 1
  vim.g.loaded_syntax = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_tutor = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1

  -- Disable providers
  vim.g.loaded_python3_provider = 1
  vim.g.loaded_node_provider = 1
  vim.g.loaded_ruby_provider = 1
  vim.g.loaded_perl_provider = 1

  -- Shada
  vim.opt.shadafile = 'NONE'
end

-- This is a simple wrapper that avoids problems, like colors not getting
-- applied at startup in certain files, or missing colors in plugins if you lazy
-- load.
--
-- We are basically applying the colorscheme at first, and set an
-- autocommand to reapply the colorscheme when everything has been loaded.
--
-- To modify this colorscheme go to ./colors/jetjbp.lua from the root of this
-- repo.
---@param name string
---@return boolean @ Returns false and sends notification if it fails to
---find/load the colorscheme and
function utils.colorscheme(name)
  local ok, _ = pcall(vim.api.nvim_cmd, { cmd = 'colorscheme', args = { name } }, {})

  if not ok then
    vim.schedule(function() vim.notify('Colorscheme not found', vim.log.levels.INFO) end)
    return false
  end

  vim.api.nvim_create_autocmd('UIEnter', {
    callback = function() vim.api.nvim_cmd({ cmd = 'colorscheme', args = { name } }, {}) end,
  })
  return true
end

-- Restore session: Folds, view of the window, marks, command line history, and
-- cursor position.
function utils.session()
  vim.opt.number = true -- Display line number on the side

  -- Setup the initial load and maintain some settings between buffers
  local save_sessions = vim.api.nvim_create_augroup('save_sessions', {})

  vim.cmd('silent! loadview') -- Load the view for the current buffer

  vim.api.nvim_create_autocmd('BufWinEnter', {
    desc = 'Load the view of the buffer',
    group = save_sessions,
    callback = function()
      if utils.avoid_filetype() then return end
      vim.cmd('silent! loadview') -- Load the view for the opened buffer
      return utils.restore_cursor_position() -- Restore the cursor position
    end,
  })

  vim.api.nvim_create_autocmd('BufWinLeave', {
    desc = 'Save the view of the buffer',
    group = save_sessions,
    callback = function()
      if utils.avoid_filetype() then return end
      return vim.cmd('silent! mkview')
    end,
  })

  vim.opt.shadafile = ''
  vim.api.nvim_cmd({
    cmd = 'rshada',
    bang = true,
  }, {})
end

-- Wrapper for setting highlights groups
---@param mode string|table
---@param table table
function utils.set_hl(mode, table)
  -- Highlights
  if type(mode) == 'table' then
    for _, groups in pairs(mode) do
      vim.api.nvim_set_hl(0, groups, table)
    end
  else
    vim.api.nvim_set_hl(0, mode, table)
  end
end

function utils.restore_cursor_position()
  -- TODO(santigo-zero): Each time you open a file with git files or find files
  -- in Telescope the cursor is shifted one column to the left
  local markpos = vim.api.nvim_buf_get_mark(0, '"') -- Get position of last saved edit
  local line = markpos[1]
  local col = markpos[2]
  -- If the cursor line position is less than 1, but not bigger than the lines of the buffer then
  if line <= vim.api.nvim_buf_line_count(0) then
    vim.api.nvim_win_set_cursor(0, { line, col }) -- Set the position
    if vim.fn.foldclosed(line) ~= -1 then -- And check if there's a closed fold
      return vim.cmd('normal! zo')
    end
  end
end

function utils.not_interfere_on_float()
  -- Do not open floating windows if there's already one open
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      vim.notify('There is a floating window open already', vim.log.levels.WARN)
      return false
    end
  end

  return true
end

-- Randomize a set of items between startups
---@param option any
---@param T table
function utils.append_by_random(option, T)
  local randomized = option:append(T[math.random(1, #T)])
  return randomized
end

-- Wrapper for functions, it works like pcall
-- Varargs can't be used as an upvalue, so store them
-- in this table first.
---@param function_pointer function
---@param ... any
function utils.wrap(function_pointer, ...)
  local params = { ... }

  return function() function_pointer(unpack(params)) end
end

---@param str string
---@return string|boolean @ Either an empty string or false
function utils.is_empty(str) return str == '' or str == nil end

function utils.is_git()
  local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
  if is_git:match('true') then
    vim.cmd('doautocmd User IsGit')
    return true
  else
    return false
  end
end

-- Filetypes to ignore
---@return table
utils.IGNORE_FT = {
  'TelescopePrompt',
  'gitcommit',
  'gitdiff',
  'netrw',
  'packer',
}

-- If there's a filetype that I want to ignore return true, so you can do
-- something like:
-- if utils.avoid_filetype() then
--   return
-- end
---@return boolean @ Return false if the filetype of the buffer is matching the
---table utils.IGNORE_FT
function utils.avoid_filetype()
  if vim.tbl_contains(utils.IGNORE_FT, vim.bo.filetype) then
    return true
  else
    return false
  end
end

function utils.conditionals()
  vim.schedule(function()
    -- Conditionals
    local conditionals = vim.api.nvim_create_augroup('conditionals', {})

    -- Run a comprobation for git, if the file is under git control there's no
    -- need to create an autocommand
    if utils.is_git() then
      return
    else
      -- If the current buffer wasn't under git version control run the
      -- comprobation each time you change of directory
      vim.api.nvim_create_autocmd('DirChanged', {
        group = conditionals,
        callback = function() return utils.is_git() end,
      })
    end
  end)
end

function utils.get_fg_hl(hl_group) return vim.api.nvim_get_hl_by_name(hl_group, true).foreground end
function utils.get_bg_hl(hl_group) return vim.api.nvim_get_hl_by_name(hl_group, true).background end

-- Return whatever it is that you have on the register "
---@return string @ From the register "
function utils.get_yanked_text()
  -- Yanked text
  return vim.fn.getreg('"')
end

-- Conditional for width of the terminal
---@return boolean
function utils.hide_at_term_width() return vim.opt.columns:get() > 90 end

return utils