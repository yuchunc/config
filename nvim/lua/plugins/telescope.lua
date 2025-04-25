return {
  {
    -- ➤ 先於任何映射或延遲載入前執行
    event = "VeryLazy",

    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    },

    init = function()
      -- 刪除 LazyVim 預設的 <leader>/ 綁定
      pcall(vim.keymap.del, "n", "<leader>/")
      -- 綁定新的 live_grep_args
      vim.keymap.set("n", "<leader>/", function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end, { desc = "Live Grep (Args)", silent = true })
    end,

    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = telescope.extensions.file_browser.actions
      local lga_actions = require("telescope-live-grep-args.actions")

      -- 1) 合併 defaults
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {}, -- 你可在這裡加 insert 模式快捷
          n = {},
        },
      })

      -- 2) 保留現有 pickers （例如 diagnostics）
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = { preview_cutoff = 9999 },
        },
      })

      -- 3) 合併 extensions，不覆蓋原本的 file_browser
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
            i = { ["<C-k>"] = lga_actions.quote_prompt() },
          },
        },
      })

      -- 4) 啟動 Telescope 與所有 extension
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("live_grep_args")
    end,
  },
}
