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
  -- All plugins added here will be installed and updated by packer
  -- By telling the name of the github repository packer will install and update it

  -- Everytime a file is saved this plugin checks if everything is up to date.
  use("wbthomason/packer.nvim") -- This the packer plugin it self

  -- Plugins with lua functions that many other lua plugins use
  use("nvim-lua/plenary.nvim")


  ----------- Language Servers Protocol --------------------------
  ----- Core LSP packages
  use("neovim/nvim-lspconfig")   --> Core package to configure LSP servers
  use("williamboman/mason.nvim") --> UI to install/update/manage and manage LSP servers, linters, and formatters
  use("hrsh7th/nvim-cmp")        --> The main completion engine for Neovim
  -- use("jose-elias-alvarez/null-ls.nvim") --> Framework for integrating external tools with LSPs (formatter, linters, code scanners, code actions, etc)

  ----- Core LSP packages Integration
  use("williamboman/mason-lspconfig.nvim") --> Integrated mason with nvim-lsp
  use("hrsh7th/cmp-nvim-lsp")              --> Integrated nvim-cmp with nvim-lsp
  -- use("jayp0521/mason-null-ls.nvim")       --> Integrated mason with null-ls

  --- CMP package enhancements
  use("hrsh7th/cmp-buffer")       --> cmp source for buffer words
  use("hrsh7th/cmp-path")         --> cmp source for file paths
  use("onsails/lspkind.nvim")     -- Integrates with cmp to display the auto complete icons
  use("L3MON4D3/LuaSnip")         --> provides a snippet engine for nvim-cmp
  use("saadparwaiz1/cmp_luasnip") --> integrates luasnip with cmp
  use('honza/vim-snippets')       --> snippets for many languages
  -- use("rafamadriz/friendly-snippets")

  --- Lsp-config package enhancements
  use({ "j-hui/fidget.nvim" }) -- Show the status of the current LSP server
  use({
    "glepnir/lspsaga.nvim",    -- Hover info, code actions, diagnostics, etc...
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

  --- LSPs for specific languages enhancements
  use("jose-elias-alvarez/typescript.nvim") -- Enhances typescript LSP with specific extra features
  use("carlsmedstad/vim-bicep")             -- Provides syntax highlighting and identation


  --- LSPs error handling
  use("folke/trouble.nvim") -- Displays the errors in a list
  -------------------------------------------------------------------
  -------------------------------------------------------------------


  ---------- User Interface Plugins ----------
  -- NeoVim Themes. They are here downloaded and must be configured at colorscheme.lua
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "ellisonleao/gruvbox.nvim" })
  use("AlexvZyl/nordic.nvim")
  use("comfysage/evergarden")

  -- Changes the opaquiness of the not focused windows
  use({ "levouh/tint.nvim" })

  -- Better UI for the command line
  use({
    "VonHeikemen/fine-cmdline.nvim",
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
  })

  -- Statusline. Creates a customizable line at the bottom of the screeen
  use("nvim-lualine/lualine.nvim")

  -- Cokeline. It creates a customizable line at the top of the screen
  use({
    "willothy/nvim-cokeline",
    commit = "8b877a9",
    requires = {
      "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
      "kyazdani42/nvim-web-devicons", -- If you want devicons
    },
  })

  -- Diagram tool for neovim
  use({ -- Install the image plugin to render the diagrams
    "3rd/image.nvim",
    opts = {}
  })

  use({ -- Install the plugin to write the diagrams
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = { -- you can just pass {}, defaults below
      renderer_options = {
        mermaid = {
          background = nil, -- nil | "transparent" | "white" | "#hex"
          theme = nil,      -- nil | "default" | "dark" | "forest" | "neutral"
          scale = 1,        -- nil | 1 (default) | 2  | 3 | ...
          width = nil,      -- nil | 800 | 400 | ...
          height = nil,     -- nil | 600 | 300 | ...
        },
        plantuml = {
          charset = nil,
        },
        d2 = {
          theme_id = nil,
          dark_theme_id = nil,
          scale = nil,
          layout = nil,
          sketch = nil,
        },
        gnuplot = {
          size = nil,  -- nil | "800,600" | ...
          font = nil,  -- nil | "Arial,12" | ...
          theme = nil, -- nil | "light" | "dark" | custom theme string
        },
      }
    },
  })

  ---------- Window related plugins ----------
  -- Split windos within TMUX. Examples: press space sk
  use("christoomey/vim-tmux-navigator")

  -- Maximize and restore current window. This uses keymap shortcuts
  use("szw/vim-maximizer")

  -- Winresize. resize all the new vim windows
  use("simeji/winresizer")

  ---------- Vim essentials plugins ----------
  -- Surround selection (words, sentences)
  use("tpope/vim-surround")

  ---- Replace word with the one in the register
  -- Example: yiw (copy the whole word)  griw (replace the word with the register)
  use("vim-scripts/ReplaceWithRegister")

  -- Comment with gc. Example: select with visual mode and press 'gc'
  use("numToStr/Comment.nvim")

  ---- Making notes
  -- Example: press space and 'ww' to open the wiki notes
  use("vimwiki/vimwiki")

  -- Highlight trailing whitespace
  use("johnfrankmorgan/whitespace.nvim")

  -- auto closing
  use("windwp/nvim-autopairs")                                 -- autoclose parens, brackets, quotes, etc...
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
		  commit = "ec33d4b"
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
  -- Seach and Replace in Multiple files using regex
  use("nvim-pack/nvim-spectre")

  -- Harpoon
  use("ThePrimeagen/harpoon") -- Track files that you want to give attention to.

  --- Undo tree
  use("mbbill/undotree")

  ---- Buffer Management
  use("j-morano/buffer_manager.nvim")



  -- Treesitter configuration
  -- Responsible for syntax highlighting, code navigation, jumps in the code.
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -------- GIT ---------------
  -- git integration
  use("lewis6991/gitsigns.nvim")        -- show line modifications on left hand side
  -- git blame
  use("braxtons12/blame_line.nvim")     -- show the author of the commmit
  -- fugitive
  use("tpope/vim-fugitive")             -- Has all git commands inside nvim
  -- GitDiff for code reviews
  use("sindrets/diffview.nvim")         -- Added split windows to compare codes
  -- Git worktree
  use("ThePrimeagen/git-worktree.nvim") -- Manage multiple GIT branches at the same time
  -- Git Reflog
  use("rbong/vim-flog")                 -- Displays git commits as a graph


  -------- Artificial Inteligence ---------------
  -- Github copilot autocomplete
  use("zbirenbaum/copilot.lua")

  -- Github copilot chat
  use({
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      branch = "master",
    },
    opts = {
      debug = true,
    },
  })

  -- ChatGpt
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    }
  })

  --- Avante Cursor IDE Simulator
  -- Required plugins
  use('stevearc/dressing.nvim')
  use('MeanderingProgrammer/render-markdown.nvim')
  -- Optional dependencies
  use('HakonHarnes/img-clip.nvim')
  use {
    'yetone/avante.nvim',
    branch = 'main',
    run = 'make'
  }





  ---------- Environment Variables ----------------
  -- Vim Dotenv
  use("tpope/vim-dotenv") -- list of keymaps

  ---------- Database Managers ----------------
  -- use("tpope/vim-dadbod")                     -- Query DB from Neovim
  -- use("kristijanhusak/vim-dadbod-completion") -- Auto completion for vim-dadbod
  -- -- Database Manager
  -- use({
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod",                     lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     -- Your DBUI configuration
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  -- })

  -- Packer sync function
  if packer_bootstrap then
    require("packer").sync()
  end
end)
