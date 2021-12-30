-- Automatically reload file if contents changed
vim.cmd([[
    augroup _reload_on_change
        autocmd!
        autocmd FocusGained * :checktime
    augroup end
]])

-- Straight red underline instead of curly line
vim.cmd([[
    augroup _red_underline
        autocmd!
        autocmd BufRead * highlight SpellBad guibg=NONE guifg=NONE gui=underline guisp=red
    augroup end
]])

-- Highlight on yank
vim.cmd([[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'iCursor', timeout = 200})
    augroup end

    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end

    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    augroup end

    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd =
    augroup end
]])

vim.cmd([[
    augroup _color_mathparen
        autocmd!
        autocmd Colorscheme * highlight MatchParen guibg=orange
    augroup end
]])

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.cmd([[
    augroup _last_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"zz" | endif
    augroup end
]])

-- Filetype set correctly
vim.cmd([[
    augroup _filetype_correctly
        autocmd!
        autocmd BufNewFile,BufRead *.conf set filetype=dosini
    augroup end
]])

-- Default syntax highlighting for files without extension
vim.cmd([[
    augroup _files_without_extension
        autocmd!
        autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif
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

-- -- Highlight words matching the word under cursor, other colors :so $VIMRUNTIME/syntax/hitest.vim
-- vim.cmd([[
--     augroup _highlight_match
--         autocmd!
--         autocmd CursorMoved * exe printf('match iCursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
--     augroup end
-- ]])

-- Show cursor only in active window
vim.cmd([[
    augroup _cursor_on_active_window
        autocmd InsertLeave,WinEnter * set cursorline cursorcolumn
        autocmd InsertEnter,WinLeave * set nocursorline nocursorcolumn
    augroup end
]])

-- Colors in visual mode
vim.cmd([[
    augroup _colored_visual_mode
        autocmd!
        autocmd ColorScheme * highlight Visual guifg=nocombine gui=reverse
    augroup end
]])

-- Disable delimiter line in certain type of files
vim.cmd([[
    augroup _disable_colorcolumn
        autocmd!
        autocmd FileType conf,dosini,help,html,markdown,text,zsh setlocal colorcolumn=0
    augroup end
]])

-- Make the selected option in completion menus in a solid color
vim.cmd([[
    augroup _solid_color_selection
        autocmd!
        autocmd ColorScheme * highlight PmenuSel blend=0
    augroup end
]])

-- Insert cursor in orange. Normal mode cursor in reversed
vim.cmd([[
    augroup _orange_cursor_insertmode
        autocmd!
        autocmd ColorScheme * highlight iCursor guifg=nocombine guibg=orange
    augroup end
]])

-- Disable autocomment when pressing enter
vim.cmd([[
    augroup _disable_comment
        autocmd!
        autocmd BufWinEnter * :set formatoptions-=cro
    augroup end
]])

-- Hide last run command in the command line after N seconds
vim.cmd([[
    augroup _cmdline
        autocmd!
        autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 12000)
    augroup end
]])

-- Write to all buffers when exit
vim.cmd([[
    augroup _config_group
        autocmd!
        autocmd FocusLost * silent! wa!
    augroup end
]])

-- Switch to numbers when in insert mode, and to relative numbers when in command mode
vim.cmd([[
    augroup _number_toggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup end
]])

-- Show lsp diagnostics
vim.cmd([[
    augroup _show_diagnostics
        autocmd!
        autocmd CursorHold * lua vim.diagnostic.open_float()
    augroup end
]])

-- -- Use null-ls to formate text before writing the buffer to the file
-- vim.cmd([[
--     augroup _format_on_exit
--         autocmd!
--         autocmd BufWritePre * lua vim.lsp.buf.formatting()
--     augroup end
-- ]])
