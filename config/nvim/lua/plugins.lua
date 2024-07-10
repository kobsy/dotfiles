local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- My Plugins
  use { 'dracula/vim', as = 'dracula' }
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  use 'tomtom/tcomment_vim'
  use 'vim-airline/vim-airline'
  use 'kchmck/vim-coffee-script'
  use 'joukevandermaas/vim-ember-hbs'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'tpope/vim-bundler'
  use 'tpope/vim-rails'
  use 'tpope/vim-rake'
  use 'tpope/vim-obsession'
  use 'tpope/vim-dispatch'
  use 'mhinz/vim-grepper'
  use 'vim-test/vim-test'
  use 'editorconfig/editorconfig-vim'
  use 'jparise/vim-graphql'
  use 'christoomey/vim-tmux-navigator'
  use {
    'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim'
      }
  }

  -- LSP, etc.
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Copilot!
  use 'github/copilot.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

