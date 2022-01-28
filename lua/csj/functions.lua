M = {}

-- Create command to format files using null-ls formatters
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])

-- Defer plugins
function M.load_plugins()
    vim.cmd([[
        PackerLoad gitsigns.nvim
        PackerLoad hop.nvim
        PackerLoad surround.nvim
        PackerLoad pretty-fold.nvim
        PackerLoad bufferline.nvim
    ]])
end

-- Smart quit, if only 1 buffer loaded, quit neovim, if more than 2 quit the focused buffer
function M.close_or_quit()
    local bufNum = #require('bufferline.utils').get_valid_buffers()
    if bufNum <= 1 then
        vim.cmd([[ :q ]])
    end
    vim.cmd([[ :bd ]])
end

return M
