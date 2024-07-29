local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended setting from nvim-tree documentation
vim.g.loaded = 1 -- Search what does this do
vim.g.loaded_netrwPlugin = 1 -- Search what does this do
vim.opt.termguicolors = true -- Search what does this do

nvimtree.setup({
  update_cwd = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,

  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },

  actions = {
    open_file = {
      resize_window = true,
    },
  },

  view = {
    width = { "auto", "20em" },
  },

  renderer = {
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },

  git = {
    ignore = false,
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },

  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
})
