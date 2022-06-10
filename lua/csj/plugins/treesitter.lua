local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
   return
end

treesitter.setup {
   -- ensure_installed = 'all',
   ensure_installed = {
      'bash',
      'comment',
      'java',
      'javascript',
      'lua',
      'nix',
      'python',
      'toml',
      'typescript',
      'vim',
      'yaml'
   },
   sync_install = false,
   highlight = {
      enable = true,
      aditional_vim_regex_highlighting = false,
      disable = { 'latex' },
   },
   context_commentstring = {
      enable = true,
      enable_autocmd = true,
   },
   indent = {
      enable = true,
      disable = { 'yaml', 'python' },
   },
   autopairs = { enable = true },
   autotag = {
      enable = true,
      filetypes = {
         'css',
         'html',
         'javascript',
         'javascriptreact',
         'markdown',
         'svelte',
         'typescript',
         'typescriptreact',
         'vue',
         'xhtml',
         'xml',
      },
   },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = 'gnn', -- Start the selection by nodes
         node_incremental = 'gnn', -- Increment to the node with higher order
         node_decremental = 'gnp', -- Decrement to the node with lower order
         scope_incremental = 'gns', -- Select the entire group  of nodes including the braces
      },
   },
}
