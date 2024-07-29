local setup, lualine = pcall(require, "lualine")
if not setup then
  return
end

local lualine_nightfly = require("lualine.themes.nightfly")
local lualine_catppuccin = require("lualine.themes.catppuccin")
-- local lualine_gruvbox = require("lualine.themes.gruvbox")

local new_colors = {
  blue = "#65D1FF",
  green = "#3EFFDC",
  violet = "#FF61EF",
  yellow = "#FFDA7B",
  black = "#000000",
}

lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
  a = {
    gui = "bold",
    bg = new_colors.yellow,
    fg = new_colors.black,
  },
}

lualine.setup({
  options = {
    theme = lualine_catppuccin,
    section_separators = "",
    component_separators = "|",
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,
        color = { fg = "white" },
      },
      "datetime",
      "searchcount",
    },
    lualine_x = {},
  },
})
