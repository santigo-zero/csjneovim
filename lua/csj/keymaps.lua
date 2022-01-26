local M = {}
local set = vim.keymap.set
local expr, buffer, silent = { expr = true }, { buffer = true }, { silent = true }

function M.general_keybinds()
    -- Modes
    --    normal_mode = "n",
    --    insert_mode = "i",
    --    visual_mode = "v",
    --    visual_block_mode = "x",
    --    term_mode = "t",
    --    command_mode = "c",

    -- Remap space as leader key
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Semicolon
    set('n', '<Leader>;', '$a;<Esc>')
    set('v', '<Leader>;', ":'<,'>norm A;<Cr>")

    -- Colon
    set('n', '<Leader>:', '$a:<Esc>')

    -- Backslash
    set('n', '<Leader>\\', '$a \\<Esc>')

    -- Comma
    set('n', '<Leader>,', '$a,<Esc>')
    set('v', '<Leader>,', ":'<,'>norm A,<Cr>")

    -- Dot
    set('n', '<Leader>.', '$a.<Esc>')

    -- Avoid moving the cursor with space, enter or backspace when in normal mode
    set('n', '<Space>', '<Nop>')
    set('n', '<Cr>', '<Nop>')
    set('n', '<Bs>', '<Nop>')

    -- Toggle cursor line and column
    set('n', '<Leader>C', '<Cmd>set cursorline! cursorcolumn!<Cr>')

    -- Insert skeleton
    set('n', '<Leader>sk', ':0read ~/.config/nvim/skeletons/')

    -- Reload the file manually
    set('n', '<Leader>e', '<Cmd>edit!<Cr>')

    -- Smart quit
    set('n', '<Leader>q', require('csj.functions').close_or_quit)

    -- Delete all buffers
    set('n', '<Leader>Q', '<Cmd>bufdo bdelete<Cr>')

    -- Quit all buffers
    set('n', '<Leader>qq', '<Cmd>quit<Cr>')

    -- Quit all buffers without saving
    set('n', '<Leader>QQ', '<Cmd>quit!<Cr>')

    -- Write buffer
    set('n', '<Leader>w', require('csj.functions').create_dir_and_save)

    -- Write to all buffers and quit
    set('n', '<Leader>W', '<Cmd>wqall<Cr>')

    -- Write buffers as sudo
    set('n', '<Leader>x', '%!sudo tee > /dev/null %')

    -- Navigate buffers
    set('n', '<Tab>', ':bnext<Cr>', silent)
    set('n', '<S-Tab>', ':bprevious<Cr>', silent)
    set('n', '<S-l>', ':bnext<Cr>', silent)
    set('n', '<S-h>', ':bprevious<Cr>', silent)

    -- Window Navigation
    set('n', '<C-h>', '<C-w>h')
    set('n', '<C-j>', '<C-w>j')
    set('n', '<C-k>', '<C-w>k')
    set('n', '<C-l>', '<C-w>l')

    -- Resize windows
    set('n', '<C-Up>', ':resize +1<CR>')
    set('n', '<C-Down>', ':resize -1<CR>')
    set('n', '<C-Left>', ':vertical resize +1<CR>')
    set('n', '<C-Right>', ':vertical resize -1<CR>')

    -- Move current block of text up and down
    set('n', '<A-j>', ':m .+1<Cr>==') -- Normal mode
    set('n', '<A-k>', ':m .-2<Cr>==')
    set('v', '<A-j>', ":m '>+1<Cr>gv=gv") -- Visual mode
    set('v', '<A-k>', ":m '<-2<Cr>gv=gv")
    set('i', '<A-j>', '<Esc>:m .+1<Cr>==gi') -- Insert mode
    set('i', '<A-k>', '<Esc>:m .-2<Cr>==gi')

    -- Center commands
    set('n', 'n', 'nzzzv')
    set('n', 'N', 'Nzzzv')
    set('v', 'y', 'myy`y')
    set('v', 'Y', 'myY`y')
    set('v', 'J', 'mzJ`z')

    -- Opposite to J
    set('n', 'K', 'i<Cr><Esc>')

    -- Folds
    set('n', 'zo', 'zo^')
    set('n', 'zp', 'zfip')
    set('n', '<Leader>m', '<Cmd>mkview<Cr>')

    -- Paste text without overwriting yank register
    set('v', 'p', '"_dP')

    -- Delete word under cursor and paste contents
    set('n', '<Leader>P', [["_diwP]])

    -- Keep visual selection after shifting code block
    set('x', '<', '<gv')
    set('x', '>', '>gv')

    -- Undo break points
    set('i', ',', ',<C-g>u')
    set('i', '.', '.<C-g>u')
    set('i', '!', '!<C-g>u')
    set('i', '?', '?<C-g>u')
    set('i', ' ', ' <C-g>u')
    set('i', '_', '_<C-g>u')
    set('i', '-', '-<C-g>u')
    set('i', '=', '=<C-g>u')
    set('i', '<Cr>', '<Cr><C-g>u')

    -- Better navigation inside wrapped text
    set('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr)
    set('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr)

    -- Packer
    set('n', '<Leader>ps', '<Cmd>PackerSync<Cr>')
    set('n', '<Leader>pc', '<Cmd>PackerCompile profile=true<Cr>')

    -- Hop
    set({ 'n', 'v' }, '<Leader>H', require('hop').hint_words)

    -- Treehoper
    set({ 'n', 'v' }, '<Leader>h', require('tsht').nodes)

    -- Toggle nvim-tree
    set('n', '<Leader>v', '<Cmd>NvimTreeToggle<Cr>') -- ':Lex 30<cr>'

    -- Toggle Indent Blankline
    set('n', '<Leader>i', '<Cmd>IndentBlanklineToggle<Cr>')

    -- Gitsigns
    set('n', 'ghj', '<Cmd>Gitsigns next_hunk<Cr>') -- Move to the next hunk
    set('n', 'ghk', '<Cmd>Gitsigns prev_hunk<Cr>') -- Move to the previous hunk
    set('n', 'ghp', '<Cmd>Gitsigns preview_hunk<Cr>') -- Preview hunk
    set('n', 'ghr', '<Cmd>Gitsigns reset_hunk<Cr>') -- Reset hunk
    set('n', 'ghb', '<Cmd>Gitsigns reset_buffer<Cr>') -- Reset buffer hunk

    -- Cycle through relative number and number
    set('n', '<Leader>nt', require('csj.functions').cycle_numbering)

    -- Add or remove _ from iskeyword
    set('n', '<Leader>_', require('csj.functions').iskeyword_rotate)
end

-- Telescope
function M.tele_keybinds()
    local telescope = require('csj.configs.telescope')
    set('n', '<Leader>t', ':Telescope ')
    set('n', '<Leader>f', telescope.project_files)
    set('n', '<Leader>b', telescope.buffer_find)
    set('n', '<Leader>bb', telescope.buffer_buffer)
    set('n', '<Leader>B', telescope.live_grep_find)
    set('n', '<Leader>p', telescope.load_project_nvim)
end

-- LSP
function M.lsp_keymaps()
    set('n', '<Leader>lr', '<Cmd>LspRestart<Cr>', buffer)
    set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)
    set('v', '<Leader>ca', vim.lsp.buf.range_code_action, buffer)
    set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)
    set('n', '<Leader>F', vim.lsp.buf.formatting_sync, buffer)
    set('n', '<Leader>R', vim.lsp.buf.rename, buffer)
    set('n', 'gD', vim.lsp.buf.declaration, buffer)
    set('n', 'gd', vim.lsp.buf.definition, buffer)
    set('n', 'gl', vim.diagnostic.open_float, buffer)
    set('n', 'gr', vim.lsp.buf.references, buffer)
end

return M
