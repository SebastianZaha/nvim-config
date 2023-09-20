-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/mfussenegger/dotfiles/blob/master/vim/.config/nvim/ftplugin/java.lua

local jdtls = require('jdtls')

local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local home = os.getenv('HOME')
local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', vim.fn.glob('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', '/usr/share/java/jdtls/config_linux',

    -- See `data directory configuration` section in the README
    '-data', workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

config.on_attach = function(client, bufnr)
  require('custom.lsp').on_attach(client, bufnr, {
    server_side_fuzzy_completion = true,
  })

  jdtls.setup_dap({hotcodereplace = 'auto'})
  jdtls.setup.add_commands()
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
  vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
  vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
  vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
  vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
  vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
  local create_command = vim.api.nvim_buf_create_user_command
  create_command(bufnr, 'W', require('me.lsp.ext').remove_unused_imports, {
    nargs = 0,
  })
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

