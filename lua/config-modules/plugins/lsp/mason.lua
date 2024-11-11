-- It is a wrapper around lspconfig and null-ls plugins.
-- It has a UI that enables to install and uninstall LSP servers, linters, and formatters.
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- -- Plugin that integrates mason with lspconfig
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

-- -- Plugin that integrates mason with null-ls
-- local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
-- if not mason_null_ls_status then
--   return
-- end

mason.setup()

-- -- Integration of mason and lsp_config
-- -- Manages some configuration of the language servers
mason_lspconfig.setup({
  -- Ensure that the following language servers are installed
  ensure_installed = {
    "bicep", -- Enabled
    "terraformls", -- Enabled
    -- "powershell_es", -- Enabled
    "azure_pipelines_ls", -- Enabled
    "lua_ls", -- Enabled
    "bashls", -- Enabled
    "dockerls", -- Enabled
    "docker_compose_language_service", -- Enabled
    "ts_ls", -- Enabled
    "jsonls", -- Enabled
    "biome", -- Enabled
--     "snyk_ls", -- Enabled
--     "bufls", -- Enabled
--     "emmet_ls", -- Enabled
--     "html", -- Enabled
--     "cssls", -- Enabled
--     "tailwindcss", -- Enabled
  },
  -- Auto installs the ensured_installed list above
  automatic_installation = true, -- not the same as ensure_installed
})
--
-- -- Integration of mason and null_ls. Install and manages formatters and linters
-- mason_null_ls.setup({
--   -- Required that the following list of lints and formatters are installed.
--   ensure_installed = {
--     "stylua", -- lua formatter
--     "eslint_d", -- ts/js linter
--     "tflint", -- terraform linter
--     "biome", -- ts/js/json linter
--     "buf", -- protobuf linter
--     "jsonlint", -- json formatter and linter
--     "snyk", -- security scanner
--     "commitlint", -- lint commit messages
--   },
--   -- Auto installs the linters and formatters in the ensure_installed list
--   automatic_installation = true,
-- })
