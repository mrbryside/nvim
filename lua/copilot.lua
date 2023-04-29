-- use this table to disable/enable filetypes
vim.g.copilot_filetypes = { ["*"] = false, go = true }

-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
-- vim.g.copilot_filetypes = { ["*"] = false, python = true }


-- imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
-- -- Define the <C-a> mapping for Copilot
-- vim.api.nvim_set_keymap('i', '<C-a>', 'copilot#Accept()<CR>', { silent = true, expr = true })
vim.cmd([[imap <silent> <expr> <C-a> copilot#Accept("\<CR>")]])

-- Disable the <Tab> mapping for Copilot
vim.g.copilot_no_tab_map = true

-- vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>call copilot#Accept()<CR>', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-]>', '<Plug>(copilot-next)', {})
vim.api.nvim_set_keymap('i', '<C-[>', '<Plug>(copilot-previous)', {})
vim.api.nvim_set_keymap('i', '<C-0>', '<Plug>(copilot-dismiss)', {})

-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--
--                                                 *copilot-i_ALT-]*
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <Plug>(copilot-next)
--
--                                                 *copilot-i_ALT-[*
-- <M-[>                   Cycle to the previous suggestion.
-- <Plug>(copilot-previous)

vim.cmd('highlight CopilotSuggestion guifg=#555555 ctermfg=8')

-- enable filetype detection
vim.cmd('filetype plugin on')

