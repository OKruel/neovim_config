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
keymap.set("n", "<leader>fi", ":lua vim.lsp.buf.format()<cr>") -- format code
keymap.set("n", "<leader>nh", ":nohl<CR>")                     -- Clear the highlighted words
keymap.set("n", "<leader>cd", "a<C-R>=strftime('[%F - %A]')<CR><Esc>")        -- Insert the current date
keymap.set("i", "<ESC>", "<ESC>")                         -- In insert mode jk will be the same as esc
keymap.set("n", "x", '"_x')                               -- The character removed with "x" will not be added to the register
keymap.set("n", "<leader>u", ":UndotreeToggle<cr>")       -- Display the tree with the recent changes
keymap.set("n", "<leader>cy", "gg0VGy")                   -- Display the tree with the recent changes
map("n", ":", "<cmd>FineCmdline<CR>", { noremap = true }) -- Display the neovim command line in a nice input

vim.api.nvim_set_keymap("v", "<leader>dp", ":lua SurroundWithPlantUML()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>wt", require("whitespace-nvim").trim)

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




-- Database Manager
-- keymap.set("n", "<leader>do", ":DBUIToggle<cr>")                                      -- Display the tree with the recent changes
-- Folding
keymap.set("n", "<leader>Fi", ":set foldmethod=indent<CR>")
keymap.set("n", "<leader>Fm", ":set foldmethod=manual<CR>")
keymap.set("n", "<leader>Fo", "zo")                                                   -- Open folder under the cursor
keymap.set("n", "<leader>FO", "zO")                                                   -- Open all the folders recursivelly under the cursor
keymap.set("n", "<leader>Fc", "zc")                                                   -- Close folder under the cursor
keymap.set("n", "<leader>FC", "zM")                                                   -- Close all foldings
keymap.set("n", "<leader>Fa", "zR")                                                   -- Open all foldings
keymap.set("n", "<leader>Fl", "<cmd>loadview<CR>", { noremap = true, silent = true }) -- Load the last folding
keymap.set("n", "<leader>Fs", "<cmd>mkview<CR>", { noremap = true, silent = true })   -- Save the current folding
--- ChatGPT keymaps
keymap.set("n", "<leader>cg", ":ChatGPT<cr>")                                         -- Normal GPT prompt
keymap.set("v", "<leader>ct", ":ChatGPTRun add_tests<cr>")
keymap.set("v", "<leader>cc", ":ChatGPTRun complete_code<cr>")
keymap.set("v", "<leader>ce", ":ChatGPTRun explain_code<cr>")
keymap.set("v", "<leader>co", ":ChatGPTRun optimize_code<cr>")
keymap.set("v", "<leader>cf", ":ChatGPTRun fix_bugs<cr>")
keymap.set("v", "<leader>cr", ":ChatGPTRun code_readability_analysis<cr>")
--- Copilot keymaps
keymap.set("n", "<leader>cs", ":Copilot status<cr>") -- Copilot activation status
keymap.set("v", "<leader>cp", ":Copilot panel<cr>")  -- Visual Mode. Copilot options panel
keymap.set("n", "<leader>cp", ":Copilot panel<cr>")  -- Normal Mode. Copilot options panel
--- Git Keymaps Fugitive
keymap.set("n", "<leader>Gv", ":vertical Git<cr>", { noremap = true, silent = true })
keymap.set("n", "<leader>Gs", ":Git status<cr>")
-- Git diff
keymap.set("n", "<leader>Go", ":DiffviewOpen <Tab>")
keymap.set("n", "<leader>Gx", ":DiffviewClose<cr>")
keymap.set("n", "<leader>Gh", ":DiffviewFileHistory<cr>")
keymap.set("n", "<leader>Gc", ":DiffviewClose<cr>")
-- Git Log/Reflog
keymap.set("n", "<leader>Gl", ":Flogsplit<cr>")
-- Cokeline
keymap.set("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
keymap.set("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
keymap.set("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })
for i = 1, 9 do
  map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
end
--------- Windows related keymaps --------------
-- Split the windows
keymap.set("n", "<leader>s|", "<C-w>v")                     -- Split window vertically
keymap.set("n", "<leader>s-", "<C-w>s")                     -- Split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")                     -- make split windows equal width
keymap.set("n", "<leader>sx", ":bdelete<CR>")               -- close the current window
-- Changes window size
keymap.set("n", "<leader>ss", ":WinResizerStartResize<cr>") -- Increase window size

-- Nvim Sessions
keymap.set("n", "<leader>rs", ":SessionsSave<cr>") -- Saves the nvim session
keymap.set("n", "<leader>rl", ":SessionsLoad<cr>") -- Loads the previous session

-- Move to the file nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
keymap.set("n", "<leader>ex", ":NvimTreeToggle<CR>")

------ Telescope -----------------------
vim.keymap.set("n", "<leader>fh", function()
  builtin.find_files({ find_command = { "rg", "--files", "--hidden" } })
end)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fa", function()
  builtin.find_files({ cwd = "~" })
end)
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fo", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fb", ":lua require(bookmarks).extensions.bookmarks.list({layout_strategy='vertical'})") -- Bookmarks
-- Telescope Git worktrees
keymap.set("n", "<leader>fwo", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>")          -- Display the workstrees with telescope
keymap.set("n", "<leader>fwa", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>")    -- Use telescope to create a new git worktree

------ Spectre ---------
keymap.set("n", "<leader>sf", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

-- Harpoon ------
-- The file can be removed from harpoon from within the navigation window
keymap.set("n", "<leader>ho", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>") -- Toggle the harpoon view
keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>")        -- Add file to harpoon

-- Managing tabs
keymap.set("n", "<leader>to", ":tabnew<CR>")   -- Open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- Close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>")     -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")     -- go to previous tab

--- LSP ---------
-- LSP informations
keymap.set("n", "<leader>li", ":LspInfo<CR>")         -- Show LSP info
keymap.set("n", "<leader>lr", ":LspRestart Info<CR>") -- Show LSP info
-- LSP trouble list
keymap.set("n", "<leader>xx", ":TroubleToggle<CR>")   -- Show LSP info
keymap.set("n", "<leader>xr", ":TroubleRefresh<CR>")  -- Show LSP info
