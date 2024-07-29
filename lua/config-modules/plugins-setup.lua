-- Packer is a neo vim plugin manager.
-- This is where all the plugins are installed.
-- Configurations of the plugins should be in their own files if too long.
-- Packer keeps the plugins updated with their github repositories latest versions

local vim = vim
-- This code make sure that packer is installed!
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- NVim tree colors configurations
vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=rgba(0,0,0,0.7)  guifg=#FFFFFF")

-- Highlight yanked text
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  augroup END
]])

--------------- Autocommand that reloads neovim whenever you save this file. ----------------

-- Updates plugins configurations
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- Require packer
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  -- This is where we can add all the plugins
  -- By telling the name of the github repository packer will install and update it

  -- Everytime a file is saved this plugin checks if everything is up to date.
  use("wbthomason/packer.nvim") -- This the packer plugin it self

  -- Plugins with lua functions that many other lua plugins use
  use("nvim-lua/plenary.nvim")

  -- Color Themes:
  -- The color theme is downloaded here and requires config at colorscheme.lua file
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "ellisonleao/gruvbox.nvim" })
  use("AlexvZyl/nordic.nvim")
  use("comfysage/evergarden")

  -- Use interface plugins
  use({ "levouh/tint.nvim" }) -- Changes the opaquiness of the not focused windows

  -- Better UI for the command line
  use({
    "VonHeikemen/fine-cmdline.nvim",
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
  })

  ---------------------- Window related plugins--------------
  -- Split windos within TMUX
  -- Examples: press space sk
  use("christoomey/vim-tmux-navigator")

  -- Maximize and restore current window
  -- This uses keymap shortcuts
  use("szw/vim-maximizer")

  -- winresize
  use("simeji/winresizer") -- resize all the new vim windows

  ---------------------- Vim essentials plugins --------
  ---- Surround selection (words, sentences)
  use("tpope/vim-surround")

  ---- Replace word with the one in the register
  -- Example: yiw (copy the whole word)  griw (replace the word with the register)
  use("vim-scripts/ReplaceWithRegister")

  ---- Comment with gc
  -- Example: select with visual mode and press 'gc'
  use("numToStr/Comment.nvim")

  ---- Making notes
  -- Example: press space and 'ww' to open the wiki notes
  use("vimwiki/vimwiki")

  ---- Statusline
  -- It creates a customizable line at the bottom of the screeen
  use("nvim-lualine/lualine.nvim")

  -- Cokeline
  -- It creates a customizable line at the top of the screen
  use({
    "willothy/nvim-cokeline",
    commit = "8b877a9",
    requires = {
      "nvim-lua/plenary.nvim", -- Required for v0.4.0+
      "kyazdani42/nvim-web-devicons", -- If you want devicons
    },
  })
  -- Highlight trailing whitespace
  use({
    "johnfrankmorgan/whitespace.nvim",
    config = function()
      require("whitespace-nvim").setup({
        -- configuration options and their defaults

        -- `highlight` configures which highlight is used to display
        -- trailing whitespace
        highlight = "DiffDelete",

        -- `ignored_filetypes` configures which filetypes to ignore when
        -- displaying trailing whitespace
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help" },

        -- `ignore_terminal` configures whether to ignore terminal buffers
        ignore_terminal = true,
      })

      -- remove trailing whitespace with a keybinding
      vim.keymap.set("n", "<Leader>t", require("whitespace-nvim").trim)
    end,
  })

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- indentscope
  use({ "echasnovski/mini.indentscope", branch = "stable" }) -- Displayes the content inside brackets

  -- which key
  use("folke/which-key.nvim") -- list of keymaps

  -- sessions vim
  use("natecraddock/sessions.nvim") -- recover the state if the windows after you close new vim

  ------- Search files and code -----------
  ---- Nvim file tree
  use({
    "nvim-tree/nvim-tree.lua",
    commit = "ec33d4b",
  })
  use("nvim-tree/nvim-web-devicons")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("telescope")
    end,
    branch = "0.1.x",
  })
  ---- Fuzzyfinder
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  ---- Spectree words replacer
  -- Searches words with regex in the entire code base and replace it
  use("nvim-pack/nvim-spectre")

  -- Bookmarks
  use("tomasky/bookmarks.nvim") -- Add/List/Seach marks to the code

  -- Harpoon
  use("ThePrimeagen/harpoon") -- Track files that you want to give attention to.

  --- Undo tree
  use("mbbill/undotree")

  ---- Snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  ---- Buffer Management
  use("j-morano/buffer_manager.nvim")

  ----------- Language Servers Protocol --------------------------
  ---- Managing and installing language server protocol
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use({ "j-hui/fidget.nvim", tag = "legacy" }) -- Show the status of the current LSP server

  ---- Autocompletion and Language Servers
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  ---- Configuring LSP servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use({
    "glepnir/lspsaga.nvim",
    commit = "91ae0e7",
    -- branch = "main",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")

  use("carlsmedstad/vim-bicep") -- Bicep language support
  ---- Formating and linting
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- Issue tracker. List of all issues found by the LSP servers.
  use({
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  })

  -------- GIT ---------------
  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
  -- git blame
  use("braxtons12/blame_line.nvim") -- show the author of the commmit
  -- fugitive
  use("tpope/vim-fugitive") -- Has all git commands inside nvim
  -- GitDiff for code reviews
  use("sindrets/diffview.nvim") -- Added split windows to compare codes
  -- Git worktree
  use("ThePrimeagen/git-worktree.nvim") -- Manage multiple GIT branches at the same time
  -- Git Reflog
  use("rbong/vim-flog") -- Displays git commits as a graph

  ---------- Artificial Inteligence ----------------
  -- Github copilot
  use("github/copilot.vim") -- Github copilot autocomplete
  -- Github copilot chat
  use({
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      debug = true,
    },
  }) -- AI Copilot Chat
  -- ChatGpt
  use({
    "jackMort/ChatGPT.nvim",
    commit = "24bcca7",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  })

  ---------- Environment Variables ----------------
  -- Vim Dotenv
  use("tpope/vim-dotenv") -- list of keymaps

  ---------- Database Managers ----------------
  use("tpope/vim-dadbod") -- Query DB from Neovim
  use("kristijanhusak/vim-dadbod-completion") -- Auto completion for vim-dadbod
  -- Database Manager
  use({
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  })

  -- Packer sync function
  if packer_bootstrap then
    require("packer").sync()
  end
end)
