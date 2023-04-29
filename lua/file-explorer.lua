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

-- empty setup using defaults
require("nvim-tree").setup({
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
  view = {
	  mappings = {
		  custom_only = false,
		  list = {
			  { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
			  { key = "h", cb = tree_cb("close_node") },
		      { key = "v", cb = tree_cb("vsplit")}
		}
	  }
  },
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
