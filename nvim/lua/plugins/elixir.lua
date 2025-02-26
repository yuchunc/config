return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = {
        elixir = { "credo" },
      }

      opts.linters = {
        credo = {
          condition = function(ctx)
            return vim.fs.find({ ".credo.exs" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      }
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     lexical = {
  --       root_dir = function(...)
  --         return require("lspconfig.util").root_pattern(".git")(...)
  --       end,
  --       single_file_support = true,
  --       filetypes = { "elixir", "eelixir", "heex" },
  --       cmd = { "~/.local/share/nvim/mason/bin/lexical" },
  --       settings = {},
  --     },
  --     setup = {
  --       lexical = function(_, opts)
  --         require("lspconfig").lexical.setup(opts)
  --       end,
  --     },
  --   },
  -- },
}
