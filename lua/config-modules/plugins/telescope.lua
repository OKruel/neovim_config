local setup, telescope = pcall(require, "telescope")
if not setup then
  return
end

local actions_setup, actions = pcall(require, "actions")
if not actions_setup then
  return
end

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    live_grep = {
      -- Configure Ripgrep arguments for live_grep
      additional_args = function()
        return { "--hidden" }
      end,
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("bookmarks")
telescope.load_extension("harpoon")
telescope.load_extension("git_worktree")

-- local function change_to_directory(prompt_bufnr)
--   local selection = actions.get_selected_entry()
--   actions.close(prompt_bufnr)
--   -- Open directory with nvim-tree or change Neovim's working directory
--   require("nvim-tree.lib").change_dir(selection.value)
--   -- Alternatively, you can change Neovim's working directory
--   -- vim.cmd('cd ' .. selection.value)
-- end
--
-- local function find_directories()
--   print("Finding directories")
--   telescope.pickers
--     .new({}, {
--       prompt_title = "Find directories",
--       finder = telescope.finders.new_oneshot_job({ "find", "--type", "d", "--hidden" }),
--       sorter = telescope.config.values.conf.generic_sorter({}),
--       attach_mappings = function(_, map)
--         map("i", "<CR>", change_to_directory)
--         map("n", "<CR>", change_to_directory)
--         return true
--       end,
--     })
--     :find()
-- end
