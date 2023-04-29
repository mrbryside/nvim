vim.opt.termguicolors = true
require("bufferline").setup{}

vim.cmd [[
  function! CloseNoNameBuffers()
    if bufname('%') != '' && bufname('#') == '' && len(getbufinfo({'buflisted':1})) > 1
      let l:prev_buffer = bufnr('#')
      silent! execute 'bdelete' l:prev_buffer
    endif
  endfunction

  augroup CloseNoNameBuffers
    autocmd!
    autocmd BufWinEnter * call CloseNoNameBuffers()
  augroup END
]]

