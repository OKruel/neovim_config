local setup, cokeline = pcall(require, "cokeline")
if not setup then
  return
end
local get_hex = require("cokeline.utils").get_hex

local green = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3



cokeline.setup({
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and "#FFFFFF" or "#7d827e"
    end,
    bg = function(buffer)
      return buffer.is_focused and "#679876" or get_hex("ColorColumn", "bg")
    end,
  },

  components = {
    {
      text = "｜",
      fg = function(buffer)
        return buffer.is_modified and yellow or green
      end,
    },
    {
      text = function(buffer)
        return buffer.devicon.icon .. " "
      end,
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    {
      text = function(buffer)
        return buffer.index .. ": "
      end,
    },
    {
      text = function(buffer)
        return buffer.unique_prefix
      end,
      -- fg = get_hex("Comment", "fg"),
      fg = function(buffer)
        return buffer.is_focused and "#FFFFFF" or "#7d827e"
      end,
      italic = true,
    },
    {
      text = function(buffer)
        return buffer.filename .. " "
      end,
      bold = function(buffer)
        return buffer.is_focused
      end,
    },
    {
      text = " ",
    },
  },

  buffers = {
    focus_on_delete = 'prev',
    new_buffers_position = 'last',
  }
})
