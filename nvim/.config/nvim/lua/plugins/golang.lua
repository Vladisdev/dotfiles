return {
  -- Go test generation, struct tags, impl interface, etc.
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- build = function()
    --   vim.cmd.GoInstallDeps()
    -- end,
    opts = {},
    keys = {
      { "<leader>cgt", "<cmd>GoTagAdd json<cr>", desc = "Add JSON tags" },
      { "<leader>cgT", "<cmd>GoTagRm json<cr>", desc = "Remove JSON tags" },
      { "<leader>cge", "<cmd>GoIfErr<cr>", desc = "Generate if err" },
      { "<leader>cgi", "<cmd>GoImpl<cr>", desc = "Implement interface" },
      { "<leader>cga", "<cmd>GoTestAdd<cr>", desc = "Add test for function" },
      { "<leader>cgA", "<cmd>GoTestsAll<cr>", desc = "Add tests for all functions" },
    },
  },

  -- Enhanced Go debugging
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = { delve = { detached = false } },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  -- Override gopls settings for better experience
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              fieldalignment = false,
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = {
                "-.git",
                "-.vscode",
                "-.idea",
                "-.vscode-test",
                "-node_modules",
              },
          },
          init_options = {
            semanticTokens = false,
          },
          },
        },
      },
    },
  },
}
