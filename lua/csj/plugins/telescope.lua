local set = vim.keymap.set
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local previewers = require('telescope.previewers')

-- Ignore big files
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

-- Themes
local clean_dropdown = require('telescope.themes').get_dropdown { previewer = false } -- Dropdown Theme

local function project_files()
  local opts = vim.deepcopy(clean_dropdown)
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--column',
      '--hidden',
      '--line-number',
      '--no-heading',
      '--smart-case',
      '--vimgrep',
      '--with-filename',
      '--color=never',
      '--line-number',
      '--trim',
    },
    path_display = { 'smart' },
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    color_devicons = true,
    prompt_prefix = ' ',
    selection_caret = ' ',
    entry_prefix = '  ',
    selection_strategy = 'reset',
    initial_mode = 'insert',
    buffer_previewer_maker = new_maker,
    sorting_strategy = 'ascending',
    winblend = 9,
  },

  extensions = {
    ['ui-select'] = { clean_dropdown },
  },
}

telescope.load_extension('projects')
telescope.load_extension('ui-select')

set('n', 'gr', '<CMD>Telescope lsp_references theme=dropdown<CR>')
set('n', 't/', '<CMD>Telescope live_grep theme=dropdown<CR>')
set('n', 't//', '<CMD>Telescope current_buffer_fuzzy_find theme=dropdown<CR>')
set('n', 'tf', project_files)
set('n', 'tp', '<CMD>Telescope projects<CR>')
set('n', 'tt', '<CMD>Telescope<CR>')