-- import trouble plugin safely
local status, trouble = pcall(require, "trouble")
if not status then
  return
end

-- configure treesitter
 trouble.setup({

})
