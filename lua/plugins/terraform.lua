-- In lua/plugins/terraform.lua
return {
  -- Terraform formatting config
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.terraform = { "terraform_fmt" }
      opts.formatters_by_ft.hcl = { "terraform_fmt" }

      -- Important: Use hcl formatter for terragrunt
      opts.formatters_by_ft.terragrunt = { "terragrunt_hclfmt" }

      -- Define formatters
      opts.formatters = opts.formatters or {}
      opts.formatters.terragrunt_hclfmt = {
        command = "terragrunt",
        args = { "hclfmt", "--terragrunt-hclfmt-file", "$FILENAME" },
        stdin = false,
      }
    end,
  },

  -- TreeSitter config
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
      end
    end,
  },

  -- Fix filetype detection for Terragrunt
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Add autocmd to set up filetype correctly
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "terragrunt.hcl", "*.hcl" },
        callback = function()
          -- Set filetype to hcl instead of terragrunt
          vim.bo.filetype = "hcl"
          -- Store an internal variable to know it's terragrunt for formatter
          vim.b.is_terragrunt = true
        end,
      })
    end,
  },

  -- Add custom formatter command for terragrunt
  {
    "LazyVim/LazyVim",
    config = function()
      vim.keymap.set("n", "<leader>tg", function()
        local file = vim.fn.expand("%")
        local result = vim.fn.system("terragrunt hclfmt --terragrunt-hclfmt-file " .. file)
        if vim.v.shell_error ~= 0 then
          vim.notify("Terragrunt formatting error: " .. result, vim.log.levels.ERROR)
        else
          vim.cmd("e") -- Reload the file
          vim.notify("Terragrunt formatting complete", vim.log.levels.INFO)
        end
      end, { desc = "Format Terragrunt file" })
    end,
  },
}
