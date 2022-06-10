local ok_cmp, cmp = pcall(require, 'cmp')

if not ok_cmp then
   print('cmp not okay')
   return
end

local ok_snippets, luasnip = pcall(require, 'luasnip')
if not ok_snippets then
   return
end

require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
   local col = vim.fn.col('.') - 1
   return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local kind_icons = {
   Text = ' ',
   Method = ' ',
   Constructor = ' ', -- 
   Field = ' ', -- ﰠ
   Variable = ' ',
   Class = ' ', -- ﴯ
   Property = ' ', -- ﰠ
   Unit = '塞 ', -- 
   Value = ' ',
   Enum = ' ',
   Keyword = ' ',
   Snippet = ' ', -- 
   Color = ' ', --   
   File = ' ', -- 
   Reference = ' ', -- 
   Folder = ' ',
   EnumMember = ' ',
   Constant = ' ',
   Struct = ' ', -- ﯟ   פּ
   Event = ' ',
   Operator = ' ',
   TypeParameter = ' ',
   Function = ' ',
   Interface = ' ',
   Module = ' ',
}

local set_hl = require('csj.utils').set_hl
set_hl('CmpItemAbbrDeprecated', { strikethrough = true, fg = '#808080' })
set_hl({ 'CmpItemAbbrMatch', 'CmpItemAbbrMatchFuzzy' }, { bold = true, fg = '#d7827e' })
set_hl({ 'CmpItemKindVariable', 'CmpItemKindInterface', 'CmpItemKindText' }, { fg = '#9ccfd8' })
set_hl({ 'CmpItemKindFunction', 'CmpItemKindMethod', 'CmpItemKindKeyword' }, { fg = '#c4a7e7' })
set_hl({ 'CmpItemKindProperty', 'CmpItemKindUnit' }, { fg = '#e0def4' })

cmp.setup {
   snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body)
      end,
   },
   window = {
      -- documentation = "native",
      documentation = {
         border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
         winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
      },
      completion = {
         border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
         winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
      },
   },
   formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = function(entry, vim_item)
         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
         vim_item.kind = string.format('%s', kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
         vim_item.menu = ({
            luasnip = 'Snippet',
            nvim_lsp = 'LSP',
            nvim_lua = 'NVIM_LUA',
            path = 'Path',
            buffer = 'Buffer',
         })[entry.source.name]
         return vim_item
      end,
   },
   mapping = cmp.mapping.preset.insert {
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping {
         i = cmp.mapping.abort(),
         c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm { select = true },
      ['<Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expandable() then
            luasnip.expand()
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         elseif check_backspace() then
            fallback()
         else
            fallback()
         end
      end, {
         'i',
         's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, {
         'i',
         's',
      }),
   },
   sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
   }, {
      { name = 'buffer' },
   }),
   experimental = {
      ghost_text = true,
   },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = 'buffer' },
   },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = 'path' },
   }, {
      { name = 'cmdline' },
   }),
})
