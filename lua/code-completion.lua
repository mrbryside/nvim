-- -- completeopt is used to manage code suggestions
-- -- menuone: show popup even when there is only one suggestion
-- -- noinsert: Only insert text when selection is confirmed
-- -- noselect: force us to select one from the suggestions
-- vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}
-- -- shortmess is used to avoid excessive messages
-- vim.opt.shortmess = vim.opt.shortmess + { c = true}
--
-- -- Fixed column for diagnostics to appear
-- -- Show autodiagnostic popup on cursor hover_range
-- -- Goto previous / next diagnostic warning / error 
-- -- Show inlay_hints more frequently 
-- vim.cmd([[
-- set signcolumn=yes
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])
-- -- Database completion
-- vim.api.nvim_exec(
--   [[
--       autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
--       autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
--   ]],
--   false
-- )
-- local cmp = require'cmp'
-- cmp.setup({ 
--   -- Required by vsnip
--   snippet = {
--     expand = function(args)
--         vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   -- Add Mappings to control the code suggestions
--   mapping = {
--     -- Shift+TAB to go to the Previous Suggested item
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--     -- Tab to go to the next suggestion
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     -- CTRL+SHIFT+f to scroll backwards in description
--     ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
--     -- CTRL+F to scroll forwards in the description
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     -- CTRL+SPACE to bring up completion at current Cursor location
--     ['<C-Space>'] = cmp.mapping.complete(),
--     -- CTRL+e to exit suggestion and close it
--     ['<C-e>'] = cmp.mapping.close(),
--     -- CR (enter or return) to CONFIRM the currently selection suggestion
--     -- We set the ConfirmBehavior to insert the Selected suggestion
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       -- select = true,
--     })
-- },
--
--   -- sources are the installed sources that can be used for code suggestions
--   sources = {
--       { name = 'path' },
--       { name = 'nvim_lsp' },
--       { name = 'nvim_lsp_signature_help'}, 
--       { name = 'nvim_lua'},
--       { name = 'buffer'},
--       { name = 'vsnip' },
--   },
--   -- Add borders to the windows
--    window = {
--       completion = cmp.config.window.bordered(),
--       documentation = cmp.config.window.bordered(),
--   },
--   -- add formating of the different sources
--     formatting = {
--       fields = {'menu', 'abbr', 'kind'},
--       format = function(entry, item)
--           local menu_icon ={
--               nvim_lsp = 'λ',
--               vsnip = '⋗',
--               buffer = 'b',
--               path = 'p'
--           }
--           item.menu = menu_icon[entry.source.name]
--           return item
--       end,
--   },
-- })
--


local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        path = "[Path]",
        nvim_lsp = "[Lsp]",
        buffer = "[Buffer]",
        luasnip = "[Snippet]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "path" },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help'}, 
    { name = 'nvim_lua'},
    { name = "buffer" },
    { name = "luasnip" },
    -- { name = 'vsnip' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
