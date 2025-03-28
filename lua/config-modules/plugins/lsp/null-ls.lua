-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

-- Concepts:
-- Null_ls injects actions into LSPs (e.g. formatting, linting, etc.)

-- for conciseness
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

-- Configuration for auto save
-- local augroup = vim.api.nvim_create_augroup("lspformatting", {})

-- Null_ls configurations
null_ls.setup({
  -- setup code_actions, formatters & linters
  sources = {
    null_ls.builtins.completion.luasnip,

    null_ls.builtins.code_actions.shellcheck,



    -- Formatters
    formatting.shfmt.with({}),
    formatting.stylua.with({}),
    formatting.buf.with({}),

    null_ls.builtins.formatting.prettierd.with({
      filetypes = { "html", "css", },
    }),

    -- Diagnostic
    diagnostics.commitlint.with({}),
    diagnostics.jsonlint.with({}),
    diagnostics.buf,

    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
      end,
    }),
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        -- group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
