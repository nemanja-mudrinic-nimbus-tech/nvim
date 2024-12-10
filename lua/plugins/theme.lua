return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      palette = "wildcharm", -- Use the 'wildcharm' palette
    },
    config = function()
      vim.cmd.colorscheme("wildcharm") -- Load the gruvbox theme
    end,
  },
}
