-- init.lua
vim.opt.number = true
-- Wrapping
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.linebreak = true
vim.opt.breakindent = true -- wrapped lines maintain proper indentation
vim.opt.showbreak = "↪ "
vim.opt.guicursor = "n:block,v:ver25,i:ver25,r:hor20,o:hor50"
-- Make 'j' and 'k' move by visual lines when wrapped
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', '<Up>', 'gk', { noremap = true, silent = true })

vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { noremap = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true })

-- shift up/down 4 spaces
vim.keymap.set('n', '<S-Down>', '4j', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', '4k', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Down>', '<Esc>4ja', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Up>', '<Esc>4ka', { noremap = true, silent = true })

-- Alt + Up / Alt + Down to move the current line up or down
vim.keymap.set("i", "<A-Up>",   "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-Up>",   ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-Up>",   ":m .-2<CR>==")

-- Save with 'gs' because i don't like pressing ':'
vim.keymap.set("n", "gs", function()
  vim.cmd("w")  -- run :w to save
  print("file saved")
end, { desc = "Save file with gs" })

-- Yank file to system clipboard
vim.keymap.set("n", "<leader>Y", 'ggVGy', { noremap = true, silent = true })

vim.cmd([[command! Q q]])

-- vim-plug
vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " :MarkdownPreview

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'lewis6991/gitsigns.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'mason-org/mason.nvim'
Plug 'mason-org/mason-lspconfig.nvim'

Plug 'windwp/nvim-autopairs'

Plug 'lewis6991/hover.nvim'

Plug 'hrsh7th/nvim-cmp' " completion engine
Plug 'hrsh7th/cmp-nvim-lsp' " asks LSP server for relevant suggestions
Plug 'hrsh7th/cmp-buffer' " suggestions for current buffer (code context)
Plug 'hrsh7th/cmp-path' " auto suggests filesystem path completions

Plug 'rachartier/tiny-inline-diagnostic.nvim'

Plug 'nvim-lualine/lualine.nvim' " status bar
Plug 'nvim-tree/nvim-web-devicons' " icons to be used in status bar
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " neovim theme

call plug#end()
]]

require("nvim-autopairs").setup {}

-- Status line
require('lualine').setup{
  options = { theme = 'nightfly' }
}
-- Theme
require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true
  }
})
vim.cmd.colorscheme("catppuccin")

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require',
        },
      },
    },
  },
})

-- mason (easily install languuage servers for error detection, definitions, hints, etc.)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "lua_ls", "ts_ls", "gopls", "clangd" },
    automatic_enable = true,
})

-- Hover (floating window shift+k for window)
require('hover').config({
  --- List of modules names to load as providers.
  --- @type (string|Hover.Config.Provider)[]
  providers = {
    'hover.providers.diagnostic',
    'hover.providers.lsp',
    'hover.providers.dap',
    'hover.providers.man',
    'hover.providers.dictionary',
    -- Optional, disabled by default:
    -- 'hover.providers.gh',
    -- 'hover.providers.gh_user',
    -- 'hover.providers.jira',
    -- 'hover.providers.fold_preview',
    -- 'hover.providers.highlight',
  },
  preview_opts = {
    border = 'rounded'
  },
  -- Whether the contents of a currently open hover window should be moved
  -- to a :h preview-window when pressing the hover keymap.
  preview_window = false,
  title = true,
  mouse_providers = {
    -- 'hover.providers.lsp',
  },
  mouse_delay = 800
})

-- Setup keymaps
vim.keymap.set('n', 'K', function()
  require('hover').open()
end, { desc = 'hover.nvim (open)' })

vim.keymap.set('n', 'gK', function()
  require('hover').enter()
end, { desc = 'hover.nvim (enter)' })

vim.keymap.set('n', '<C-p>', function()
    require('hover').switch('previous')
end, { desc = 'hover.nvim (previous source)' })

vim.keymap.set('n', '<C-n>', function()
    require('hover').switch('next')
end, { desc = 'hover.nvim (next source)' })

-- Mouse support
vim.keymap.set('n', '<MouseMove>', function()
  require('hover').mouse()
end, { desc = 'hover.nvim (mouse)' })

vim.o.mousemoveevent = true

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),

    ["<Esc>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort() -- close menu, stay in insert mode
      else
        fallback() -- fallback to normal <Esc>
      end
    end, { "i" }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
})

local diag = require("tiny-inline-diagnostic")
diag.setup({
    options = {
        add_messages = {
            display_count = true,
        },
        multilines = {
            enabled = true,
        },
    },
})
diag.change_severities({ vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN })

-- Squiggly wiggly error lines
vim.diagnostic.config({
  virtual_text = false, -- inline text
  signs = true,          -- signs in gutter
  underline = true,
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
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- show signs in gutter
  numhl      = true,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = { follow_files = true },
  attach_to_untracked = true,
}

