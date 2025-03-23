local setup, diagram = pcall(require, "diagram")
if not setup then
  return
end

diagram.setup({
  integrations = {
    require("diagram.integrations.markdown"),
    require("diagram.integrations.neorg"),
  },
  renderer_options = {
    mermaid = {
      theme = "forest",
    },
    plantuml = {
      charset = "utf-8",
      width = "100%",
      height = "auto"
    },
    d2 = {
      theme_id = 1,
    },
    gnuplot = {
      theme = "dark",
      size = "800,600",
    },
  },
})


vim.api.nvim_create_user_command("DiagramNewBuffer", function()
  vim.cmd("new") -- Opens a new buffer
  diagram.render()
end, {})

