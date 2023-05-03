-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
  vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
  vim.keymap.set('n', 'D', '', { buffer = bufnr })
  vim.keymap.del('n', 'D', { buffer = bufnr })
  vim.keymap.set('n', 'E', '', { buffer = bufnr })
  vim.keymap.del('n', 'E', { buffer = bufnr })

  -- custom key
  vim.keymap.set('n','l', api.node.open.edit, opts('Edit'))
  vim.keymap.set('n','h', api.tree.close, opts('close'))
  vim.keymap.set('n','v', api.node.open.vertical, opts('close'))
  -- end
  vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'P', function()
    local node = api.tree.get_node_under_cursor()
    print(node.absolute_path)
  end, opts('Print Node Path'))

  vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
end

-- empty setup using defaults
require("nvim-tree").setup({
  on_attach = on_attach,
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  sort_by = "case_sensitive",
  update_focused_file = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {'.git'}
  },
  hijack_cursor = false,
  update_cwd = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
  },
  diagnostics = {
	enable = true,
	icons = {
		hint = "",
		info = "",
		warning = "",
		error = "",
	},
  },
  filters = {
    -- dotfiles = true,
	custom = {"^.git$"}
  },
  -- view = {
  -- 	  mappings = {
  -- 		  custom_only = false,
  -- 		  list = {
  -- 			  { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
  -- 			  { key = "h", cb = tree_cb("close_node") },
  -- 		      { key = "v", cb = tree_cb("vsplit")}
  -- 		}
  -- 	  }
  -- },
  renderer = {
        highlight_git = true,
        root_folder_modifier = ":t",
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            }
        }
    },
})


-- -- OR setup with some options
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })
