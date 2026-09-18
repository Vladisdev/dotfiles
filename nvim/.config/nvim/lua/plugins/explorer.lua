return {
  -- Disable competing file explorers
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- Configure Snacks Explorer
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {},
      picker = {
        sources = {
          explorer = {
            layout = { layout = { position = "right" } },
            hidden = true,
            ignored = true,
            exclude = { ".git", "node_modules", "dist", "build", "vendor", ".next" },
          },
        },
      },
    },
  },
}
