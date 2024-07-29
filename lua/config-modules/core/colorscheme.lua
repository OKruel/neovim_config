-- Colorscheme configuration
-- It is composed by a color scheme and a theme
-- The theme uses the color scheme in their configuration

local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
  print("Colorscheme not found!")
  return
end
