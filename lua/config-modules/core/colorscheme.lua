-- Colorscheme configuration
-- It is composed by a color scheme and a theme
-- The theme uses the color scheme in their configuration

-- Select the theme that will be used with Nvim
local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
  print("Colorscheme not found!")
  return
end

-- Add custom collors to the nvim tree folders
vim.cmd([[highlight NvimTreeFolderName guifg=#677D6A]])
vim.cmd([[highlight NvimTreeOpenedFolderName guifg=#BEC6A0]])
vim.cmd([[highlight NvimTreeEmptyFolderName guifg=#677D6A]])
