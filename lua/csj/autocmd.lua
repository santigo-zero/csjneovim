-- Automatically reload file if contents changed
vim.cmd([[
    augroup _reload_on_change
        autocmd!
        autocmd FocusGained * :checktime
    augroup end
]])

-- Highlight on yank
vim.cmd([[
    augroup _general_settings
        autocmd!
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'iCursor', timeout = 333})
    augroup end
]])

-- Other remaps
vim.cmd([[
    augroup _remaps
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    augroup end
]])

-- Filetype set correctly
vim.cmd([[
    augroup _filetype_correctly
        autocmd!
        autocmd BufNewFile,BufRead *.conf set filetype=dosini
    augroup end
]])

-- Git filetype
vim.cmd([[
    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end
]])

-- Markdown filetype
vim.cmd([[
    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    augroup end
]])

-- Autoresize
vim.cmd([[
    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd =
    augroup end
]])

-- Default settings for files without extension
vim.cmd([[
    augroup _files_without_extension
        autocmd!
        autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | setlocal filetype=markdown syntax=markdown | endif
    augroup end
]])

-- Trim whitespace on save
vim.cmd([[
    augroup _trim_whitespace
        autocmd!
        autocmd BufWritePre * :%s/\s\+$//e
    augroup end
]])

-- Indentation override for this type of files
vim.cmd([[
    augroup _indent_filetype
        autocmd!
        autocmd FileType css,html,scss,xhtml,xml setlocal shiftwidth=2 tabstop=2
        autocmd FileType go setlocal shiftwidth=8 tabstop=8
    augroup end
]])

-- Show cursor only in active window
vim.cmd([[
    augroup _cursor_on_active_window
        autocmd InsertLeave,WinEnter * setlocal cursorline cursorcolumn
        autocmd InsertEnter,WinLeave * setlocal nocursorline nocursorcolumn
    augroup end
]])

-- Disable delimiter line in certain type of files
vim.cmd([[
    augroup _disable_colorcolumn
        autocmd!
        autocmd FileType conf,dosini,help,html,markdown,text,zsh setlocal colorcolumn=0
    augroup end
]])

-- Disable autocomment when pressing enter
vim.cmd([[
    augroup _disable_auto_comment
        autocmd!
        autocmd BufEnter * set formatoptions-=cro
        autocmd BufWinEnter * set formatoptions-=cro
    augroup end
]])

-- Switch to numbers when while on insert mode or cmd mode, and to relative numbers when in normal mode
vim.cmd([[
    augroup _number_toggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
        autocmd CmdLineEnter * set norelativenumber
        autocmd CmdLineLeave * set relativenumber
    augroup end
]])

-- Hide last run command in the command line after N seconds
vim.cmd([[
    augroup _cmdline
        autocmd!
        autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 12000)
    augroup end
]])

-- Skeletons
vim.cmd([[
    augroup _insert_skeleton
        autocmd!
        autocmd BufNewFile * silent! execute '0r ~/.config/nvim/skeletons/skeleton.'.expand("<afile>:e")
        autocmd BufNewFile * silent! execute 'norm Gdd'
    augroup END
]])

-- Save and load view of the file we are working on
vim.cmd([[
    augroup _save_and_load_view
        autocmd!
        autocmd BufWritePre * mkview
        autocmd BufWinEnter * silent! loadview
    augroup end
]])

-- Load plugins
vim.cmd([[
    augroup _load_plugins
        autocmd!
        autocmd VimEnter * lua vim.defer_fn(M.load_plugins, 33)
    augroup end
]])
