-- This import all the plugins with packer. Plugin manager
require("config-modules.plugins-setup") -- This should be at the top of this file

-- Core configurations
require("config-modules.core.options")
require("config-modules.core.keymaps")
require("config-modules.core.colorscheme")

-- Plugins with custom configuration files
require("config-modules.plugins.comment")
require("config-modules.plugins.nvim-tree")
require("config-modules.plugins.lualine")
require("config-modules.plugins.telescope")
require("config-modules.plugins.nvim-cmp")
require("config-modules.plugins.autopairs")
require("config-modules.plugins.treesitter")
require("config-modules.plugins.gitsigns")
require("config-modules.plugins.vimwiki")
require("config-modules.plugins.bookmarks")
require("config-modules.plugins.gitblame")
require("config-modules.plugins.indentscope")
require("config-modules.plugins.winresize")
require("config-modules.plugins.sessions")
require("config-modules.plugins.which-keys")
require("config-modules.plugins.chat-gpt")
require("config-modules.plugins.themes.catppuccin")
require("config-modules.plugins.themes.evergarden")
require("config-modules.plugins.themes.gruvbox")
require("config-modules.plugins.spectre")
require("config-modules.plugins.harpoon")
require("config-modules.plugins.copilot")
require("config-modules.plugins.cokeline")
require("config-modules.plugins.buffer-manager")
require("config-modules.plugins.tint")
require("config-modules.plugins.fine-cmdline")

-- Plugins custom configurations to language servers
require("config-modules.plugins.lsp.mason") -- Manage installation of LSPs and Linters/formatters
require("config-modules.plugins.lsp.lspsaga") -- Used with live_grep telescope function
require("config-modules.plugins.lsp.lspconfig") -- Installation of LSPs
require("config-modules.plugins.lsp.null-ls") -- Installation of linters/formatters
require("config-modules.plugins.lsp.fidget") -- Displays LSPs status
