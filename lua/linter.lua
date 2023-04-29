  local lint = require('lint')
  --lint.linters.cargo = {
  --  cmd = 'cargo check',
  --  stdin = true,
  --  args = {},
  --  stream = 'both',
  --  ignore_exitcode = false,
  --  env = nil,
  --}
  -- Add Linter by File type
  lint.linters_by_ft = {
    go = {'golangcilint', 'revive'},
    --rust = {'cargo'},
  }
  -- Get golangcilint to configure it
  local golangcilint = require("lint.linters.golangcilint")
  golangcilint.args = {
    'run',
    '--out-format',
    'json',
    }

-- Configure revive
  -- local revive = require("lint.linters.revive")
  -- revive.args = {
  --   '-config',
  --   vim.fn.getcwd() .. '/config.toml'
  -- }
  local revive = lint.linters.revive
  revive.args = {
    '-config',
    vim.fn.stdpath('config') .. '/lint-config.toml'
  }


-- Add TryLint on bufferwrite as a auto command
-- vim.api.nvim_create_autocmd({ "BufWritePost", "*" }, {
--   callback = function()
-- 	reset_linter()
--     require("lint").try_lint()
--   end,
-- })

-- vim.api.nvim_exec([[
--   autocmd BufWritePost * lua _G.reset_linter_and_lint()
-- ]], false)

vim.api.nvim_exec([[
]], false)
   -- autocmd BufWritePre *.go GoImports
   -- autocmd BufWritePre * lua vim.lsp.buf.format()
