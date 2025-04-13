local setup, copilot = pcall(require, "copilot")
if not setup then
  return
end

copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "right", -- | top | left | right | horizontal | vertical
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    trigger_on_accept = true,
    keymap = {
      accept = "<C-l>",
      accept_word = false,
      accept_line = false,
      next = "<C-j>",
      prev = "<C-k>",
      dismiss = "<C-h>",
    },
  },
  filetypes = {
    ["*"] = true,
  },
  auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
  logger = {
    file = vim.fn.stdpath("log") .. "/copilot-lua.log",
    file_log_level = vim.log.levels.DEBUG,
    print_log_level = vim.log.levels.INFO,
    trace_lsp = "off", -- "off" | "messages" | "verbose"
    trace_lsp_progress = false,
    log_lsp_messages = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 20
  workspace_folders = {},
  copilot_model = "",  -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
  root_dir = function()
    return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
  end,
  should_attach = function(_, _)
    if not vim.bo.buflisted then
      -- logger.debug("not attaching, buffer is not 'buflisted'")
      vim.notify("Copilot Attached", vim.log.levels.INFO)
      return false
    end

    if vim.bo.buftype ~= "" then
      vim.notify("Not attaching, buffer 'buftype' is " .. vim.bo.buftype, vim.log.levels.INFO)
      return false
    end

    return true
  end,
  server = {
    type = "nodejs", -- "nodejs" | "binary"
    custom_server_filepath = nil,
  },
  server_opts_overrides = {},
})
