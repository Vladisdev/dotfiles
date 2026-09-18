-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", function()
  local current = vim.api.nvim_get_current_buf()
  local alternate = vim.fn.bufnr("#")
  local target

  if alternate > 0 and alternate ~= current and vim.bo[alternate].buflisted then
    target = alternate
  else
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
        target = buf
        break
      end
    end
  end

  if target then
    vim.api.nvim_set_current_buf(target)
  end

  vim.cmd("bdelete " .. current)
end, { desc = "Delete buffer" })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Delete other buffers" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = false }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = false }) end, { desc = "Next diagnostic" })
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
