vim.cmd([[imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")]])
vim.g.copilot_no_tab_map = true

vim.cmd([[ highlight CopilotSuggestion guifg=#5ba473 ctermfg=8 ]])

-- Keymaps
vim.keymap.set("i", "<C-s>", "<Plug>(copilot-suggest)", { noremap = false })
vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)", { noremap = false })
vim.keymap.set("i", "<C-j>", "<Plug>(copilot-previous)", { noremap = false })
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-next)", { noremap = false })
