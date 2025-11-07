-- init.lua
vim.opt.number = true
-- Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true -- wrapped lines maintain proper indentation
vim.opt.showbreak = "↪ "
-- Make 'j' and 'k' move by visual lines when wrapped
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', '<Up>', 'gk', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })

vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = "n:block,v:ver25,i:ver25,r:hor20,o:hor50"

-- Save with 'gs' because i don't like pressing ':'
vim.keymap.set("n", "gs", function()
  vim.cmd("w")  -- run :w to save
  print("file saved")
end, { desc = "Save file with gs" })

-- Yank whole file to system clipboard
vim.keymap.set("n", "<leader>Y", 'ggVGy', { noremap = true, silent = true })

-- vim-plug
vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()
]]

-- Theme
require("catppuccin").setup({
  flavour = "macchiato",
})

vim.cmd.colorscheme("catppuccin")

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" }, -- parsers
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- nvim-cmp setup
local cmp = require'cmp'

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Define the config for Pyright
vim.lsp.config('pyright', {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
})

-- Enable Pyright for Python files
vim.lsp.enable('pyright')

-- Squiggly wiggly error lines
vim.diagnostic.config({
  virtual_text = false,   -- disable inline text
  signs = false,          -- diable signs in gutter
  underline = {           -- only underline errors and warnings
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    }
  },
  update_in_insert = true,
  severity_sort = true, -- show higher severity first
})

-- git
require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },   -- green line for additions
    change       = { text = '┃' },   -- yellow line for changes
    delete       = { text = '_' },   -- red line for deletions
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  signcolumn = true,  -- show signs in gutter
  numhl      = true,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = { follow_files = true },
  attach_to_untracked = true,
}
