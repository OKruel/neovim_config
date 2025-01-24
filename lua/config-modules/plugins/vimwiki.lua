vim.g.vimwiki_list = {
  {
    path = "~/vimwiki",
    syntax = "markdown",
    ext = ".md",
  },
}

vim.keymap.set("i", "<C-J>", "<Plug>VimWikiListNextSymbol")

vim.g.vimwiki_folding = 'custom'


vim.cmd [[
  " Configure bold text in Vimwiki
  autocmd FileType vimwiki hi VimwikiBold ctermfg=71 guifg=#3CB371 gui=bold    " Dark Green equivalent in cterm
  autocmd FileType vimwiki hi VimwikiItalic ctermfg=67 guifg=#4682B4 gui=italic    " Dark Slate Blue equivalent in cterm
  autocmd FileType vimwiki hi VimwikiCode ctermfg=203 guifg=#FF6347 guibg=#282828    " Dark Red equivalent in cterm
]]
