return {
  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- elixir
        "lexical",

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
    opts = {
      servers = {
        ["*"] = {
          keys = {
            {
              "gd",
              function()
                -- DO NOT RESUSE WINDOW
                require("telescope.builtin").lsp_definitions({ reuse_win = false })
              end,
              desc = "Goto Definition",
              has = "definition",
            },
          },
        },
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
      },
    },
  },
}
