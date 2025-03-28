local sessions_setup, sessions = pcall(require, "sessions")
if not sessions_setup then
  return
end

sessions.setup({
  -- autocmd events which trigger a session save
  --
  -- the default is to only save session files before exiting nvim.
  -- you may wish to also save more frequently by adding "BufEnter" or any
  -- other autocmd event
  events = { "VimLeavePre" },

  -- default session filepath
  --
  -- if a path is provided here, then the path argument for commands and API
  -- functions will use session_filepath as a default if no path is provided.
  session_filepath = "~/.config/nvim/sessions",

  -- treat the default session filepath as an absolute path
  -- if true, all session files will be stored in a single directory
  absolute = true,
})
