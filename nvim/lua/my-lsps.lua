-- IS This how it works??


local on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Hover (gh)
  bufmap("n", "gh", vim.lsp.buf.hover, "LSP Hover")

  -- Go to definition (gd)
  bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")

  -- Next diagnostic (g])
  bufmap("n", "g[", vim.diagnostic.goto_next, "Next Diagnostic")

  -- Previous diagnostic (g[)
  bufmap("n", "g]", vim.diagnostic.goto_prev, "Prev Diagnostic")

  -- Optional: Show diagnostics in a floating window
  bufmap("n", "<leader>di", vim.diagnostic.open_float, "Show Diagnostics")

  bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

  bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

  bufmap("v", "<leader>=", vim.lsp.buf.format, "Format")
end

local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "nvim_lsp" },
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('basedpyright', {
  on_attach = on_attach,
  -- capabilities = capabilities
  -- init_options = {
  --   settings = {
  --     -- Ruff language server settings go here
  --   }
  -- }
})

vim.lsp.enable('basedpyright')

capabilities = require("cmp_nvim_lsp").default_capabilities()


vim.lsp.config('vtsls', {
  on_attach = on_attach,
  capabilities = capabilities
})

vim.lsp.enable('vtsls')

