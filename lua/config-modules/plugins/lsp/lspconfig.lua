local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end
--
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end
--
-- local typescript_setup, typescript = pcall(require, "ts_ls")
-- if not typescript_setup then
--   return
-- end
--
--
-- -- enable keybinds for available lsp server
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }
  --
  -- set keybinds
  vim.keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)                         -- show definition, references
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)          -- got to declaration
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)                -- see definition and make edits in window
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)       -- go to implementation
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)            -- see available code actions
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                 -- smart rename
  vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
  vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                 -- see outline on right hand side

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")      -- rename file and update imports
    vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")    -- remove unused variables (not in youtube nvim video)
  end
end
--
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
--
-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
--
----- Installation and Configuration of Language Servers -----

-- configure snyk language server
-- NOTE: snyk needs to authenticated through opening a browser window
-- lspconfig["snyk_ls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

lspconfig["bashls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "sh", "zsh" },
})

lspconfig["powershell_es"].setup({
  capabilities = capabilities,
  bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
  shell = "pwsh",
  root_dir = function(fname)
    return lspconfig.util.root_pattern("*.ps1")(fname) or lspconfig.util.path.dirname(fname)
  end,
  on_attach = on_attach,
  filetypes = { "ps1", "psd1", "psm1" },
})

lspconfig["azure_pipelines_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function(fname)
    return lspconfig.util.root_pattern("*.yaml")(fname) or lspconfig.util.path.dirname(fname)
  end,
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "/azure-pipeline*.y*l",
          "/*.azure*",
          "Azure-Pipelines/**/*.y*l",
          "Pipelines/*.y*l",
          "pipelines/*.y*l",
          "*.yaml",
          "*.yml",
        },
      },
    },
  },
})

lspconfig["dockerls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["docker_compose_language_service"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["terraformls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["jsonls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["biome"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


lspconfig["ts_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["bicep"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  -- cmd = { "bicep-lsp", "--stdio" },
  -- cmd = { "/home/olavokruel/.local/share/nvim/mason/bin/bicep-lsp" },
  filetypes = { "bicep" },
  -- root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
  root_dir = function(fname)
    return lspconfig.util.root_pattern("bicepconfig.json")(fname) or
           lspconfig.util.root_pattern("*.bicep")(fname) or
           lspconfig.util.path.dirname(fname)
  end,
  settings = {
    bicep = {
      telemetry = {
        enable = false,
      },
      experimentalFeaturesEnabled = {
        extensibility = true,
        sourceMapping = true,
        paramsFiles = true,
        dynamicImport = true,
      },
    },
  },
})

-- -- configure yaml language server
-- lspconfig["yamlls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     yaml = {
--       schemas = {
--         ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
--         ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
--       },
--     },
--   },
--   -- filetypes = { "yaml", "yml" },
-- })


vim.lsp.set_log_level("debug")
