-- LSP SAGA
-- LSP Saga provides UIs to interact with null-ls functionalities like code actions, hover, signature help, etc.


-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  -- This is the window that has the definition, reference and implementation.
  -- Currently its keymap is gf
  finder = {
    max_height = 0.7,
    min_width = 30,
    max_width = 90,
    force_max_height = true,
    force_max_width = true,
    keys = {
      jump_to = "p",
      expand_or_jump = "o",
      vsplit = "v",
      split = "h",
      tabe = "t",
      tabnew = "r",
      quit = { "q", "<ESC>" },
      close_in_preview = "<ESC>",
    },
  },
  definition = {
    max_height = 0.7,
    min_width = 30,
    max_width = 90,
    force_max_height = true,
    force_max_width = true,
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>h",
    tabe = "<C-c>t",
    quit = "q",
  },
  ui = {
    colors = {
      normal_bg = "#022746",
    },
  },
})
