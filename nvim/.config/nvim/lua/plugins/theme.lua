return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- mocha | macchiato | frappe | latte
      transparent_background = false,
      integrations = {
        neotree = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        mason = true,
        notify = true,
        which_key = true,
        lazy = true,
        noice = true,
        cmp = true,
        dap = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
  },

  -- Tell LazyVim to use this colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
