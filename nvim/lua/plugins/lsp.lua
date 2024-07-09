return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- elixir
        -- "lexical",

        -- lua
        "selene",
        "stylua",

        -- shell
        "shellcheck",
        "shfmt",

        -- FE
        "css-lsp",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gd",
        function()
          -- DO NOT RESUSE WINDOW
          require("telescope.builtin").lsp_definitions({ reuse_win = false })
        end,
        desc = "Goto Definition",
        has = "definition",
      }
    end,
    opts = {
      cssls = {},
      tailwindcss = {
        root_dir = function(...)
          return require("lspconfig.util").root_pattern(".git")(...)
        end,
      },
      -- lexical = {
      --   root_dir = function(...)
      --     return require("lspconfig.util").root_pattern(".git")(...)
      --   end,
      --   single_file_support = true,
      --   filetypes = { "elixir", "eelixir", "heex" },
      --   cmd = { "~/.local/share/nvim/mason/bin/lexical" },
      --   settings = {},
      -- },
    },
    setup = {},
  },
}
