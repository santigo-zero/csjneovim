-- Highlight on yank
vim.cmd([[
    augroup _general_settings
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup = 'Visual'})
    augroup END
]])

-- Quit with q in this filetypes
vim.cmd([[
    augroup _remaps
        autocmd!
        autocmd FileType qf,help,man,lspinfo,startuptime nnoremap <silent> <buffer> q :close<CR>
    augroup END
]])

-- Filetype set correctly
vim.cmd([[
    augroup _filetype_correctly
        autocmd!
        autocmd BufNewFile,BufRead *.conf set filetype=dosini
    augroup END
]])

-- Autoresize
vim.cmd([[
    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd =
    augroup END
]])

-- Trim whitespace on save
vim.cmd([[
    augroup _trim_whitespace
        autocmd!
        autocmd BufWritePre * :%s/\s\+$//e
    augroup END
]])

-- Show cursor only in active window
vim.cmd([[
    augroup _cursor_on_active_window
        autocmd WinEnter * setlocal cursorline cursorcolumn
        autocmd WinLeave * setlocal nocursorline nocursorcolumn
    augroup END
]])

-- Disable autocomment when pressing enter
vim.cmd([[
    augroup _disable_auto_comment
        autocmd!
        autocmd BufEnter * setlocal formatoptions-=cro
    augroup END
]])

-- Switch to numbers when while on insert mode or cmd mode, and to relative numbers when in normal mode
vim.cmd([[
    augroup _number_toggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
        autocmd CmdLineEnter * set norelativenumber
        autocmd CmdLineLeave * set relativenumber
    augroup END
]])

-- Hide last run command in the command line after N seconds
vim.cmd([[
    augroup _cmdline
        autocmd!
        autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 12000)
    augroup END
]])

-- Skeletons
vim.cmd([[
    augroup _insert_skeleton
        autocmd!
        autocmd BufNewFile * silent! execute '0r ~/.config/nvim/skeletons/skeleton.'.expand("<afile>:e")
        autocmd BufNewFile * silent! execute 'norm Gdd'
    augroup END
]])

-- Open file at last position
vim.cmd([[
    augroup _file_last_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif
    augroup END
]])

-- Save and load view of the file we are working on
vim.cmd([[
    augroup _save_and_load_view
        autocmd!
        autocmd BufWritePre * silent!
        autocmd BufWinEnter * silent! loadview
    augroup END
]])

-- Create missing directories before saving the buffer
vim.cmd([[
    augroup _create_missing_dirs
        autocmd!
        autocmd BufWritePre * :lua vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
    augroup END
]])

-- LSP Diagnostics
vim.cmd([[
    augroup _open_diagnostics
        autocmd!
        autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
    augroup END
]])
