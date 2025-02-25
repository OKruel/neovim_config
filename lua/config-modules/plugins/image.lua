local setup, image = pcall(require, "image")
if not setup then
  return
end

image.setup({
  backend = "kitty",        -- Use Kitty's graphics protocol for rendering
  processor = "magick_cli", -- Use ImageMagick's CLI utilities
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      floating_windows = false,              -- Render images within the buffer
      filetypes = { "markdown", "vimwiki" }, -- Filetypes to apply the integration
    },
    neorg = {
      enabled = true,
      filetypes = { "norg" },
    },
    typst = {
      enabled = true,
      filetypes = { "typst" },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = 100,
  max_height_window_percentage = 60,
  window_overlap_clear_enabled = false,                                               -- Disable clearing images when windows overlap
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
  editor_only_render_when_focused = false,                                            -- Keep images rendered even when the editor loses focus
  tmux_show_only_in_active_window = false,                                            -- Show images in all Tmux windows
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- Automatically render these image file types
})
