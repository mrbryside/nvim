local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "%.git/" },
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
}
-- search files, even hidden ones
vim.keymap.set('n', '<leader>ff', ':lua require"telescope.builtin".find_files({no_ignore=true, hidden=true})<CR>', {})
-- ripgrep files, respects gitignore
vim.keymap.set('n', '<leader>fg', ':lua require"telescope.builtin".live_grep({no_ignore=true, hidden=true})<CR>', {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
