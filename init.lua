vim.opt.runtimepath:prepend("~/.local/share/nvim/runtime")

require('plugins')
require('vim-plugins')
require('vim-setup')
require('style')
-- require('copilot')
require('custom-go')
require('mason-config')
-- require('gopls')
require('code-completion')
require('file-explorer')
require('custom-keys')
require('syntax-highlight')
require('harpoon-cfg')
require('lsp-settings')
require('debugging')
require('telescopecfg')
require('statusbar')
require('autobrackets')
require('indent-guide')
require('linter')
require('troubletab')
require('todo-comments-highlights')
require('buffer-line')
require('auto-close')
require('smooth-scroll')

 -- COMMENT
 require("nvim_comment").setup({
	operator_mapping = "<leader>/"
 })

-- ignore git
--vim.g.NERDTreeGitIgnore = 1
-- vim.g.NERDTreeIgnore = { ".git" }
