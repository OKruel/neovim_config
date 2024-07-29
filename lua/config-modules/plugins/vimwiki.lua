vim.g.vimwiki_list = {
  {
    path = "~/vimwiki",
    syntax = "markdown",
    ext = ".md",
  },
}

vim.keymap.set("i", "<C-J>", "<Plug>VimWikiListNextSymbol")
