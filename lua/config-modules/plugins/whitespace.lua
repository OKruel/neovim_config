-- This is plugin to trim all the white spaces from a file with a keymap
-- import whitespace plugin safely
local status, whitespace = pcall(require, "whitespace-nvim")
if not status then
  return
end

-- configure whitespace
whitespace.setup({
  highlight = "DiffDelete",
  ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },
  ignore_terminal = true,
  return_cursor = true,
})
