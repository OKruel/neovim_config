-- import winresize plugin safely
local status, winresize = pcall(require, "winresize")
if not status then
  return
end

-- configure winresize
winresize.setup({})
