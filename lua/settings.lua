-- NEOVIM SETTINGS IN LUA

vim.opt.guifont = 'Iosevka Nerd Font:h16'  -- Font used in GUI applications
vim.opt.laststatus = 0  -- Mode of the status bar
vim.opt.smartcase = true  -- Smart case
vim.opt.ignorecase = true  -- Ignore case
vim.opt.conceallevel = 0  -- Show text normally
vim.opt.smartindent = true  -- Smart indentation
vim.opt.iskeyword:remove { '_' }  -- Word separators
vim.opt.pumheight = 10  -- Pop up menu height
vim.opt.path = '**'  -- Search files recursively
vim.opt.tags:append './tags;,tags'  -- Where to search for ctags
vim.opt.spelllang = 'en,cjk'  -- Spell checking languages
vim.opt.timeoutlen = 333 -- Time given for doing a sequence
vim.opt.updatetime = 333  -- Faster completion - CursorHold interval
vim.opt.title = true  -- Set the window title based on the value of titlestring
vim.opt.confirm = true  -- Confirm dialogs
vim.opt.wrap = false  -- Wrap text
vim.opt.number = true  -- Display line number on the side
vim.opt.relativenumber = true  -- Display line number relative to the cursor
vim.opt.signcolumn = 'number'  -- Show/hide signs column
vim.opt.numberwidth = 3  -- Gutter column number width
vim.opt.cpoptions:append 'nm' -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.backspace = 'indent,start,eol'  -- Make backspace behave like normal again
vim.opt.clipboard = 'unnamedplus'  -- Uses the system clipboard
vim.opt.fileencoding = 'utf-8'  -- The encode used in the file
vim.opt.wildmenu = true  -- Enables "enhanced mode" of command-line completion
vim.opt.wildmode= 'full'  -- Options for wildmenu
vim.opt.winblend = 1  -- Enable transparency in floating windows and menus
vim.opt.wildignore = '*.o,*.rej,*.so'  -- File patterns for wildmenu
vim.opt.hidden = true  -- It keeps buffers open in memory
vim.opt.hlsearch = true  -- incremental search
vim.opt.mouse = 'a'  -- mouse can select, paste and
vim.opt.colorcolumn = '90'  -- Limiter line
vim.opt.cmdheight = 1  -- Space for displaying messages in the command line
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }  -- Menu options
vim.opt.inccommand = 'nosplit'  -- Live preview of :s results
vim.opt.splitbelow = true  -- Force splits to go below current window
vim.opt.splitright = true  -- Force vertical splits to go to the right of current window
vim.opt.swapfile = false  -- It does (not) creates a swapfile
vim.opt.undofile = true  -- Persistent undo - undo after you re-open the file
vim.opt.showtabline = 2  -- Show top tab bar
vim.opt.showmode = false  -- Hides/shows mode status below status line
vim.opt.showmatch = true  -- Show matching braces
vim.opt.matchtime = 1  -- Time for showing matching brace
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.tabstop = 4  -- Tab length
vim.opt.shiftwidth = 4  -- Number of spaces per tab for indentation
vim.opt.shiftround = true  -- Round indent to multiple of 'shiftwidth'
vim.opt.termguicolors = true  -- Set term gui colors
vim.opt.cursorline = true  -- Draw line on cursor
vim.opt.cursorcolumn = true  -- Draw line on cursor
vim.opt.scrolloff = 9  -- Cursor does not reach top/bottom
vim.opt.sidescrolloff = 9  -- Cursor does not reach sides

-- Neovide
vim.g.neovide_refresh_rate = 90
vim.g.neovide_cursor_vfx_mode = 'sonicboom'
vim.g.neovide_cursor_antialiasing = 1

-- Disable certain sections in :checkhealth
vim.tbl_map(
    function(p)
        vim.g['loaded_' .. p] = vim.endswith(p, 'provider') and 0 or 0
    end,
    { 'perl_provider', 'python_provider', 'ruby_provider' }
)

-- Disable certain builtin plugins
vim.g.loaded_gzip         	= 1
vim.g.loaded_tar          	= 1
vim.g.loaded_grep        	= 1
vim.g.loaded_tarPlugin    	= 1
vim.g.loaded_zipPlugin    	= 1
vim.g.loaded_2html_plugin	= 1
vim.g.loaded_netrw        	= 1
vim.g.loaded_netrwPlugin  	= 1
vim.g.loaded_matchit      	= 1
vim.g.loaded_matchparen   	= 1
vim.g.loaded_spec         	= 1

-- Show whitespaces, tabs, etc
vim.opt.list = true  -- To show them
vim.opt.listchars = {
    nbsp     = '⦸',
    extends  = '»',
    precedes = '«',
    tab      = '▷-',
    trail    = '•',
    space    = ' ',
}
vim.opt.fillchars = {
    diff     = '∙',
    eob      = ' ',
    fold     = '·',
    vert     = ' ',
}



-- KEYMAPPINGS, FUNCTIONS

vim.g.mapleader = ' '  -- Leader key

vim.api.nvim_set_keymap('n', '<Leader>;', '$a;<Esc>', {noremap = true, silent = true})  -- Quick semicolon
vim.api.nvim_set_keymap('n', '<Leader>:', '$a:<Esc>', {noremap = true, silent = true})  -- Quick colon
vim.api.nvim_set_keymap('n', '<Leader>,', '$a,<Esc>', {noremap = true, silent = true})  -- Quick comma
vim.api.nvim_set_keymap('n', '<Leader>x', ':xa<CR>', {noremap = true, silent = true})  -- Quick write and save

-- Insert empty line without leaving normal mode
vim.api.nvim_set_keymap('n', '<Leader>o', 'o<Esc>0"_D', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>O', 'O<Esc>0"_D', {noremap = true, silent = true})

-- Switch buffers using TAB and SHIFT-TAB
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true })

-- Capitalize word under cursor
vim.api.nvim_set_keymap('n', '<C-C>', 'b~', {noremap = true, silent = true})

-- Move current block
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-j>', ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-k>', ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- Center search
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Reselect selection after shifting code block
vim.api.nvim_set_keymap("x", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", ">", ">gv", { noremap = true, silent = true })

-- Toggle to show/hide searched terms
vim.api.nvim_set_keymap('n', '<C-N>', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- Yank until the end of line with Y
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', ' ', ' <C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '_', '_<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-g>u', {noremap = true, silent = true})

-- Toggle spell checking
vim.api.nvim_set_keymap('n', '<Leader>s', ':set spell!<CR>', {noremap = true, silent = true})

-- Move between windows
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true, silent = true })

-- Move windows using arrows
vim.api.nvim_set_keymap("n", "<down>", ":wincmd J<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<left>", ":wincmd H<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<up>", ":wincmd K<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<right>", ":wincmd L<CR>", {noremap = true, silent = true})

-- Give fenced codeblock in markdown files
vim.g.markdown_fenced_languages = { "bash", "rust", "python", "html", "javascript", "typescript", "css", "scss", "lua", "vim" }



-- AUTOMATION

-- Highlight on yank
vim.api.nvim_exec([[
augroup yankhighlight
autocmd!
autocmd textyankpost * silent! lua vim.highlight.on_yank()
augroup end
    ]], true)

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.api.nvim_exec([[
if has('autocmd')
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
    ]], true)



-- VIMSCRIPT ONLY FUNCTIONS

-- Filetype plugin enabled
vim.cmd 'filetype plugin on'

-- Default filetype for files without extension
vim.cmd([[ autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif ]])

-- Set correct filetype
vim.cmd([[ autocmd BufNewFile,BufRead *.conf set filetype=conf ]])

-- Colorscheme
vim.cmd 'colorscheme tokyonight'
vim.g.tokyonight_style = 'night'
vim.g.tokyodark_transparent_background = true

-- Spaces used for indentation and tabs depending on the file
vim.cmd([[
autocmd FileType xml,xhtml,dart setlocal shiftwidth=2 tabstop=2
autocmd FileType html,css,scssjavascript,lua,dart,python,c,cpp,md,sh setlocal shiftwidth=4 tabstop=4
autocmd FileType go setlocal shiftwidth=8 tabstop=8
]])

-- Trim white spaces
vim.cmd([[
fun! TrimWhitespace()
let l:save = winsaveview()
keeppatterns %s/\s\+$//e
call winrestview(l:save)
endfun
augroup JIUMYLOVE
autocmd!
autocmd BufWritePre * :call TrimWhitespace()
augroup END
]])

-- Automatic toggling between line number modes
vim.cmd([[
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])

-- Colors in visual mode
vim.cmd([[autocmd ColorScheme * highlight Visual cterm=reverse gui=reverse]])
-- vim.api.nvim_exec('highlight Visual cterm=reverse gui=reverse', true)  -- Gets overwritten by colorscheme

-- LSP MOVE TO OTHER FILES, REFORMAT EVERYTHING
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'bashls', 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end


-- Example custom server
-- local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.local/bin/sumneko_lua' -- Change to your sumneko root installation
local sumneko_root_path = '/usr/bin' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
