local which_key_status, which_key = pcall(require, "which-key")
if not which_key_status then
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 1500

-- configure which-key
which_key.setup({
  plugins = {
    spelling = {
      suggestions = 5,
    },
  },
})

-- All Personal keymaps are listed here
which_key.register({
  -- LSP Saga keymaps
  ["gf"] = { ":Lspsaga finder<cr>", "LSPsaga - Open references/definitions window" },
  ["gfo"] = { ":Lspsaga finder<cr>", "Open the window in a new buffer" },
  ["gfs"] = { ":Lspsaga finder<cr>", "Open the window in vertical split" },
  -- Personal plugins
  ["<leader>fi"] = { ":lua vim.lsp.buf.format()<cr>", "Format file" },
  ["<leader>nh"] = { ":nohl<CR>", "Clear the highlighted text" },
  ["<leader>cy"] = { "gg0VGy", "Copy entire page" },
  -- Folding
  ["<leader>Fo"] = { "zo", "Open folder under the cursor" },
  ["<leader>FO"] = { "zO", "Open all folder recursivelly under the cursor" },
  ["<leader>Fc"] = { "zc", "Close folder under the cursor" },
  ["<leader>FC"] = { "zM", "Close all folders" },
  ["<leader>Fa"] = { "zR", "Open all folders" },
  ["<leader>Fl"] = { ":loadview", "Load previous folding state" },
  ["<leader>Fs"] = { ":mkview", "Create a folding state" },
  -- Spectre Multi Files Word search and replace
  ["<leader>sf"] = { '<cmd>lua require("spectre").toggle()<CR>', "Spectre - Open" },
  ["<leader>sw"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', "Spectre - Select Word" },
  -- Chat GPT plugins
  ["<leader>cgchat"] = { ":ChatGPT<cr>", "Chat GPT prompt" },
  ["<leader>cgedit"] = { ":ChatGPTEditWithInstructions<cr>", "Edit with Instructions" },
  ["<leader>cgtest"] = { ":ChatGPTRun add_tests<cr>", "GPT - Add tests" },
  ["<leader>cgcomplete"] = { ":ChatGPTRun complete_code<cr>", "GPT - Code complete" },
  ["<leader>cgexplain"] = { ":ChatGPTRun explain_code<cr>", "GPT - Explain code" },
  ["<leader>cgoptimize"] = { ":ChatGPTRun optimize_code<cr>", "GPT - Optimize code" },
  ["<leader>cgfix"] = { ":ChatGPTRun fix_bugs<cr>", "GPT - Fix bugs" },
  ["<leader>cgread"] = { ":ChatGPTRun code_readability_analysis<cr>", "GPT - Code readability" },
  ["<leader>ci"] = { ":ChatGPTEditWithInstructions<cr>", "GPT - Prompt with instructions" },
  -- Git fugitive
  ["<leader>Gi"] = { ":Git<cr>", "Git Fugitive - Open Changes Horizontal" },
  ["<leader>Gv"] = { ":vertical Git<cr>", "Git Fugitive - Open Changes Vertical" },
  ["<leader>Gs"] = { ":Git status<cr>", "Git Fugitive - Display status" },
  ["<leader>Go"] = { ":DiffviewOpen", "Git Fugitive - Open branch list to compare" },
  ["<leader>Gx"] = { ":DiffviewClose<cr>", "Git Fugitive - Close Diff viewer" },
  ["<leader>Gh"] = { ":DiffviewFileHistory<cr>", "Git Fugitive - Display file history" },
  -- Git worktrees
  ["<leader>fw"] = {
    "",
    "Git Worktree prefix",
  },
  ["<leader>fwo"] = {
    ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
    "Show git worktrees (<c-d> to delete)",
  },
  ["<leader>fwa"] = {
    ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
    "Create git worktree",
  },
  -- LSP trouble plugin
  ["<leader>xx"] = { ":TroubleToggle<CR>", "Toggle list of LSP errors" },
  ["<leader>xr"] = { ":TroubleRefresh<CR>", "Refresh list of LSP errors" },
  -- Telescope
  ["<leader>fc"] = { "<cmd>Telescope grep_string<cr>", "Search string inside selection" },
  ["<leader>fs"] = { "<cmd>Telescope live_grep<cr>", "Search string in current working directory" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "List files in current working directoty" },
  ["<leader>fo"] = { "<cmd>Telescope buffers<cr>", "List open buffers" },
  ["<leader>fb"] = { "<cmd>Telescope bookmarks list<cr>", "List bookmarks" },
  -- Bookmarks
  ["<leader>bm"] = { "require(bookmarks).bookmark_toggle", "create and remove bookmark" },
  ["<leader>ba"] = { "require(bookmarks).bookmark_ann", "Add or edit mark annotation" },
  ["<leader>bc"] = { "require(bookmarks).bookmark_clean", "Clean ALL marks in local buffer" },
  ["<leader>bn"] = { "require(bookmarks).bookmark_next", "Jump to next bookmark" },
  ["<leader>bp"] = { "require(bookmarks).bookmark_prev", "Jump to previous bookmark" },
  -- Buffer Managment
  ["<leader>Bo"] = { "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>", "Buffer managment window" },
})
