require('go').setup()

function _G.restart_language_server()
  vim.cmd("GoInstallBinaries")
  local active_clients = vim.lsp.get_active_clients()
  for _, client in ipairs(active_clients) do
    vim.lsp.stop_client(client)
  end
  vim.cmd("edit")
end

vim.cmd("command! RestartLS lua _G.restart_language_server()")
