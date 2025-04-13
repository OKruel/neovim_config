local which_key_status, which_key = pcall(require, "which-key")
if not which_key_status then
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 1500

-- configure which-key
which_key.setup({
  plugins = {
    spelling = {
      suggestions = 5,
    },
  },
})

-- All Personal keymaps are listed here
which_key.register({ })
