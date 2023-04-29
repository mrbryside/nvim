vim.o.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.o.hlsearch = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 302
--vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.cmd('command! Q qall')
vim.cmd([[
  augroup AutoToggle
    autocmd!
	autocmd VimEnter * silent! !osascript -e 'tell application "System Events" to keystroke "-"'
  augroup END
]])
