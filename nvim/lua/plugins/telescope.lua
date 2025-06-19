-- lua/plugins/telescope.lua
-- Override LazyVim’s default Telescope spec so <leader>/ always uses
-- telescope‑live‑grep‑args, while keeping all your custom settings.

return {
  {
    "nvim-telescope/telescope.nvim",

    -- load *before* LazyVim’s own spec so we can disable its keymap first
    priority = 1000,
    lazy = false,

    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    },

    -- 1.  Disable LazyVim’s stock mapping, then add ours that calls LGA
    keys = {
      { "<leader>/", false, mode = "n" }, -- remove original mapping
      {
        "<leader>/",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Live Grep (Args)",
        mode = "n",
      },
    },

    -- 2.  Merge your existing opts (layout tweaks, extensions, etc.)
    opts = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = telescope.extensions.file_browser.actions
      local lga_actions = require("telescope-live-grep-args.actions")

      -- defaults ----------------------------------------------------------
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {},
          n = {},
        },
      })

      -- pickers -----------------------------------------------------------
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = { preview_cutoff = 9999 },
        },
      })

      -- extensions --------------------------------------------------------
      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            n = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
            },
          },
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
            },
          },
        },
      })

      -- 3.  (Re)‑initialise Telescope & extensions -----------------------
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("live_grep_args")
    end,
  },
}
