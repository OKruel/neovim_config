local setup, buffer_manager = pcall(require, "buffer_manager")
if not setup then
  return
end

buffer_manager.setup({
  width = vim.api.nvim_win_get_width(0) - 20,
})
