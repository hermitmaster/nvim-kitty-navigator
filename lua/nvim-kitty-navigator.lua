local M = {}

local kitty_is_last_pane = false

local function kitty_navigate(direction)
  local mappings = { h = 'left', j = 'bottom', k = 'top', l = 'right' }

  os.execute('kitty @ kitten neighboring_window.py' .. ' ' .. mappings[direction])
end

local function vim_navigate(direction)
  pcall(vim.cmd, 'wincmd ' .. direction)
end

function M.navigate(direction)
  local nr = vim.fn.winnr()
  local kitty_last_pane = direction == 'p' and kitty_is_last_pane

  if not kitty_last_pane then
    vim_navigate(direction)
  end

  local at_tab_page_edge = (nr == vim.fn.winnr())

  if kitty_last_pane or at_tab_page_edge then
    kitty_navigate(direction)
    kitty_is_last_pane = true
  else
    kitty_is_last_pane = false
  end
end

function M.setup()
  vim.api.nvim_set_keymap( 'n', '<c-h>', ":lua require('nvim-kitty-navigator').navigate('h')<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap( 'n', '<c-j>', ":lua require('nvim-kitty-navigator').navigate('j')<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap( 'n', '<c-k>', ":lua require('nvim-kitty-navigator').navigate('k')<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap( 'n', '<c-l>', ":lua require('nvim-kitty-navigator').navigate('l')<cr>", { noremap = true, silent = true })
end

return M
