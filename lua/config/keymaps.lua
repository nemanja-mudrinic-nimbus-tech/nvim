-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- In your lua/config/keymaps.lua file
vim.keymap.set("n", "<leader>yy", function()
  -- Get all text from the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")
  
  -- Directly call pbcopy (macOS clipboard tool)
  local temp_file = os.tmpname()
  local file = io.open(temp_file, 'w')
  file:write(content)
  file:close()
  
  os.execute('cat ' .. temp_file .. ' | pbcopy')
  os.remove(temp_file)
  
  vim.notify("File content copied to clipboard via pbcopy", vim.log.levels.INFO)
end, { desc = "Copy entire file to system clipboard" })

vim.keymap.set("n", "<leader>tc", function()
  os.execute('echo "Test clipboard" | pbcopy')
  vim.notify("Test text copied to clipboard", vim.log.levels.INFO)
end, { desc = "Test clipboard with pbcopy" })
