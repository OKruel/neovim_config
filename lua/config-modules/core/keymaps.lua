-- The leader is space. In the code below everytime leader appears it is referring to space
-- Adding <CR> makes it press enter automatically
-- kickstart.nvim in github has a initial config file!!! MUST CHECK IT OUT!!! Has typescript language server!!! And all other language servers!!! And language server manager
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local keymap = vim.keymap -- for conciseness
local builtin = require("telescope.builtin")

function DeleteBufferByIndex(index)
  -- local bufferlist = vim.api.nvim_list_bufs()
  -- print("Buffer list: ", vim.inspect(bufferlist))

  local files_output = vim.fn.execute(":files")
  print(files_output)
  -- if bufferlist[index] then
  --   vim.api.nvim_command("bd " .. bufferlist[index])
  -- else
  --   print("Invalid index: No such buffer")
  -- end
end

------ Personal keymaps -------
keymap.set("n", "<leader>pf", ":lua vim.lsp.buf.format()<cr>", { desc = "Format Code" })
keymap.set("n", "<leader>ph", ":nohl<CR>", { desc = "Clear the highlighted words" })
keymap.set("n", "<leader>pd", "a<C-R>=strftime('[%F - %A]')<CR><Esc>", { desc = "Insert the current date" })
keymap.set("n", "<leader>pc", "gg0VGy", { desc = "Personal - Copy entire file" })

-- Whitespace
keymap.set("n", "<Leader>pw", require("whitespace-nvim").trim, { desc = "Personal - Trim whitespaces" })

-- CMDline
map("n", ":", "<cmd>FineCmdline<CR>", { desc = "Nice command line input ui", noremap = true })

-- Undotree
keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { desc = "UndoTree - Display latest changes" })

-- PlantUML
vim.api.nvim_set_keymap("v", "<leader>dp", ":lua SurroundWithPlantUML()<CR>",
  { desc = "Surround with Plant UML", noremap = true, silent = true })

function SurroundWithPlantUML()
  -- Get the correct start and end positions for visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Ensure start_line is always before end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Get the selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Insert opening block at the beginning
  table.insert(lines, 1, "```plantuml")
  -- Insert closing block at the end
  table.insert(lines, "```")

  -- Replace the original selected lines with the modified lines
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

-- Folding
keymap.set("n", "<leader>Fi", ":set foldmethod=indent<CR>", { desc = "Folding - Set indent mode" })
keymap.set("n", "<leader>Fm", ":set foldmethod=manual<CR>", { desc = "Folding - Set manual mode" })
keymap.set("n", "<leader>Fo", "zo", { desc = "Open folder under the cursor" })
keymap.set("n", "<leader>FO", "zO", { desc = "Open all the folders recursivelly under the cursor" })
keymap.set("n", "<leader>Fc", "zc", { desc = "Close folder under the cursor" })
keymap.set("n", "<leader>FC", "zM", { desc = "Close all foldings" })
keymap.set("n", "<leader>Fa", "zR", { desc = "Open all foldings" })

--- Github Copilot autocomplete
keymap.set("n", "<leader>cS", ":Copilot status<cr>", { desc = "Copilot activation status" })
keymap.set("v", "<leader>cp", ":Copilot panel<cr>", { desc = "Copilot multiple suggestions panel" })
keymap.set("n", "<leader>cp", ":Copilot panel<cr>", { desc = "Copilot multiple suggestions panel" })
-- Github Copilot Chat
keymap.set("n", "<leader>ci", ":CopilotChat<cr>", { desc = "CopilotChat - Input" })
keymap.set("n", "<leader>ct", ":CopilotChatToggle<cr>", { desc = "CopilotChat - Toggle" })
keymap.set("n", "<leader>cr", ":CopilotChatReset<cr>", { desc = "CopilotChat - Reset chat" })
keymap.set("n", "<leader>cs", ":CopilotChatSave<cr>", { desc = "CopilotChat - Save chat history" })
keymap.set("n", "<leader>cl", ":CopilotChatLoad<cr>", { desc = "CopilotChat - Load chat history" })
keymap.set("n", "<leader>cm", ":CopilotChatModels<cr>", { desc = "CopilotChat - Models" })
keymap.set("n", "<leader>ce", ":CopilotChatPrompts explain<cr>", { desc = "CopilotChat - Explain selected code" })

-- Avante Copilot
keymap.set("n", "<leader>aa", ":AvanteAsk<cr>", { desc = "Avante - Single question mode" })
keymap.set("n", "<leader>at", ":AvanteChat<cr>", { desc = "Avante - Toggle Chat Mode" })
keymap.set("n", "<leader>an", ":AvanteChatNew<cr>", { desc = "Avante - New Chat Mode" })
keymap.set("n", "<leader>ax", ":AvanteClear<cr>", { desc = "Avante - Clear chat history" })
keymap.set("n", "<leader>as", ":AvanteStop<cr>", { desc = "Avante - Stop current request" })
keymap.set("n", "<leader>ah", ":AvanteHistory<cr>", { desc = "Avante - Display all chats" })
keymap.set("n", "<leader>am", ":AvanteModels<cr>", { desc = "Avante - Show models" })
keymap.set("v", "<leader>ae", ":AvanteEdit<cr>", { desc = "Avante - Edit te selected code blocks" })

--- Git Fugitive
keymap.set("n", "<leader>gv", ":vertical Git<cr>",
  { desc = "Git Fugitive - Open Changes Vertical", noremap = true, silent = true })
keymap.set("n", "<leader>gs", ":Git status<cr>", { desc = "Git Fugitive - Display status" })

-- Git diff
keymap.set("n", "<leader>go", ":DiffviewOpen <Tab>", { desc = "Git Fugitive - Open branch list to compare" })
keymap.set("n", "<leader>gx", ":DiffviewClose<cr>", { desc = "Git Fugitive - Close Diff viewer" })
keymap.set("n", "<leader>gh", ":DiffviewFileHistory<cr>", { desc = "Git Fugitive - Display file history" })
keymap.set("n", "<leader>gc", ":DiffviewClose<cr>", { desc = "Git Fugitive - Close Diff viewer" })

-- Git Log/Reflog
keymap.set("n", "<leader>gl", ":Flogsplit<cr>", { desc = "Git Fugitive - Open git log" })

-- Cokeline
keymap.set("n", "<Tab>", "<Plug>(cokeline-focus-next)", { desc = "Cokeline - Next buffer", silent = true })
for i = 1, 9 do
  map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
end
--------- Windows related keymaps --------------
keymap.set("n", "<leader>Wv", "<C-w>v", { desc = "Window Manager - Split vertically" })
keymap.set("n", "<leader>W-", "<C-w>s", { desc = "Window Manager - Split horizontally" })
keymap.set("n", "<leader>We", "<C-w>=", { desc = "Window Manager - Split windows equal width" })
keymap.set("n", "<leader>Wx", ":bdelete<CR>", { desc = "Window Manager - Close current window" })
keymap.set("n", "<leader>Ws", ":WinResizerStartResize<cr>", { desc = "Window Manager - Changes window size" })

-- Nvim Sessions
keymap.set("n", "<leader>ss", ":SessionsSave<cr>", { desc = "Sessions - Saves" })
keymap.set("n", "<leader>sl", ":SessionsLoad<cr>", { desc = "Sessions - Load previous session" })

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "NvimTree - Focus" })
keymap.set("n", "<leader>ex", ":NvimTreeToggle<CR>", { desc = "NvimTree - Toggle" })

------ Telescope -----------------------
vim.keymap.set("n", "<leader>fh", function()
  builtin.find_files({ find_command = { "rg", "--files", "--hidden" } })
end, { desc = "Telescope - Search hidden files" })
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope - Search files" })
keymap.set("n", "<leader>fa", function()
  builtin.find_files({ cwd = "~" })
end, { desc = "Telescope - Search files in home directory" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>",
  { desc = "Telescope - Search string in current working directory" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope - Search string inside selection" })
keymap.set("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "Telescope - List open buffers" })
keymap.set("n", "<leader>fb", ":lua require(bookmarks).extensions.bookmarks.list({layout_strategy='vertical'})",
  { desc = "Telescope - List bookmarks" })
keymap.set("n", "<leader>fw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
  { desc = "Telescope - List git worktrees" })

------ Spectre ---------
keymap.set("n", "<leader>Sf", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
keymap.set("n", "<leader>Sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

-- Buffer Management ------
keymap.set("n", "<leader>Bo", "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>",
  { desc = "Buffer Management - Toggle" })


-- Harpoon ------
-- The file can be removed from harpoon from within the navigation window
keymap.set("n", "<leader>ho", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
  { desc = "Harpoon - Toggle" })
keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Harpoon - Add file" })


--- LSP ---------
-- LSP informations
keymap.set("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP - Show info" })
keymap.set("n", "<leader>lr", ":LspRestart Info<CR>", { desc = "LSP - Restart" })
keymap.set("n", "<leader>ls", ":LspSaga def+ref+imp<CR>", { desc = "LSPSaga - Find dependencies" })

-- -- LSP trouble list
keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", {desc = "Trouble - toggle"})
