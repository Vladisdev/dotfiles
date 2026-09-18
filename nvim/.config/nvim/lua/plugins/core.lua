return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          severity = { min = vim.diagnostic.severity.WARN },
        },
        signs = true,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
          header = "",
        },
      },
    },
  },
  -- Better UI for input/select dialorgs
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
