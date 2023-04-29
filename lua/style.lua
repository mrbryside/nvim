require("gruvbox").load()

-- Line numbers and line endings
vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"
vim.wo.number = true

vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=none guifg=none")
vim.o.background = "dark" -- or "light" for light mode
require("gruvbox").setup({
    palette_overrides = {
        bright_green = "#BDBCB6",
    }
})
vim.cmd([[colorscheme gruvbox]])

-- Adding the same comment color in each theme
vim.cmd([[
	augroup CustomCommentCollor
		autocmd!
		autocmd VimEnter * hi Comment guifg=#2ea542
	augroup END
]])
