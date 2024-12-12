local telescope = require("telescope.builtin")
return {
  {
    "princejoogie/dir-telescope.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependecies = {
      "princejoogie/dir-telescope.nvim",
      config = function()
        require("dir-telescope").setup({
          hidden = true,
          no_ignore = false,
          show_preview = true,
        })
      end,
    },
    keys = {
      {
        "<leader>fp",
        function()
          telescope.find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader><leader>",
        function()
          telescope.find_files()
        end,
        desc = "Find files on root level",
      },
      {
        "<leader>fd",
        function()
          require("telescope").extensions.dir.find_files()
        end,
        desc = "Find files in specified directory",
      },
      {
        "<leader>fdw",
        function()
          require("telescope").extensions.dir.live_grep()
        end,
        desc = "Find word in specified directory",
      },
      {
        "<leader>fw",
        function()
          telescope.live_grep()
        end,
        desc = "Find word on root level",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        file_ignore_patterns = {
          "node_modules",
          ".git",
        },
      },
    },
    config = function(_, opts)
      local tele = require("telescope")
      tele.setup(opts)
      tele.load_extension("dir")
    end,
  },
}
