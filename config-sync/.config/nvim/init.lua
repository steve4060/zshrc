-- Normal vim config

vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab") vim.cmd("set relativenumber")
vim.cmd("set number")
vim.cmd("set cursorline")

-- learder

vim.g.mapleader = " "

-- lazy.nvim install

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazy configuration

require("lazy").setup("plugins")

-- telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- treesitter

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "java" },
    highlight = { enable = true},
    indent = { enable = true },
}

-- neo-tree

vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')

-- after loading of plugins

vim.cmd[[colorscheme tokyonight-moon]]
