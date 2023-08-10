local dap = require('dap')

-- :h dap-configuration
-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-codelldb
-- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md#starting-a-new-debug-session
dap.configurations.cpp = {
  {
    name = "launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "attach",
    type = "codelldb",
    request = "attach",
    pid = "${command:pickProcess}",
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
   {
    name = "ladybird",
    type = "codelldb",
    request = "launch",
    program = vim.fn.getcwd() .. '/Meta/gn/out/ladybird-debug/bin/ladybird',
    args = { },
    env = {
      SERENITY_SOURCE_DIR = "${workspaceFolder}",
    },
    cwd = "${workspaceFolder}",
    initCommands = {"command source ${workspaceFolder}/.lldbinit"},
    stopOnEntry = false,
  }
}
