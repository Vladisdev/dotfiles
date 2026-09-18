return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          settings = {
            semanticTokens = false,
          },
        },
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
            format = false,
          },
        },
      },
    },
  },
  -- Auto close and rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  -- Better TypeScript errors
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {},
  },

  -- Package.json dependency info
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "BufRead package.json",
    opts = { autostart = true, hide_up_to_date = true, notifications = false },
    keys = {
      { "<leader>ns", function() require("package-info").show() end, ft = "json", desc = "Show package info" },
      { "<leader>nu", function() require("package-info").update() end, ft = "json", desc = "Update dependency" },
      { "<leader>nd", function() require("package-info").delete() end, ft = "json", desc = "Delete dependency" },
      { "<leader>ni", function() require("package-info").install() end, ft = "json", desc = "Install dependencies" },
    },
  },
}
