return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- elixir
        "lexical",

        -- lua
        "selene",
        "stylua",
        "luacheck",

        -- shell
        "shellcheck",
        "shfmt",

        -- FE
        "css-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
      })
    end,
  },
}
