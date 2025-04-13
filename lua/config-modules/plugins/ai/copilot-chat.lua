local setup, co_pilot_chat = pcall(require, "CopilotChat")
if not setup then
  return
end

-- Plugins that uses github copilot also as a chat
-- It uses also lynx browser, tiktoken, ripgrep, and curl

co_pilot_chat.setup({ })
