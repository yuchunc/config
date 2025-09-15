return {
  {
    "catppuccin/nvim",
    init = function()
      -- Shim for Catppuccin bufferline integration API changes
      local ok, mod = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and type(mod) == "table" and mod.get == nil and type(mod.get_theme) == "function" then
        mod.get = mod.get_theme
      end
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        local ok, mod = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and mod then
          local highlights = nil
          if type(mod.get) == "function" then
            highlights = mod.get()
          elseif type(mod.get_theme) == "function" then
            highlights = mod.get_theme()
          end
          if highlights ~= nil then
            opts.highlights = highlights
          end
        end
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
