local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        formatting.prettier.with({
            extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
        }),
        formatting.stylua,
        formatting.black.with({
            extra_args = {
                -- '--fast'
                '--skip-string-normalization',
            },
        }),
        diagnostics.flake8.with({
            extra_args = {
                '--max-line-length', '120'
            },
        }),
    },
})

require('null-ls').setup({
    sources = {
        formatting.prettier.with({
            extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
        }),
    },
})
