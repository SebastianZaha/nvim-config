-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  -- [] mappings for args, quickfix, buffers, tabs, locations
  -- [<Space> to add line before cursor, [e to exchange line with line above
  -- yo<char> to toggle some options
  -- :help unimpaired
  'tpope/vim-unimpaired',

  -- :Bdelete and :Bwipeout to not mess up window layout
  'famiu/bufdelete.nvim',

  -- remember last position per file
  { 'vladdoster/remember.nvim', config = [[ require('remember') ]] },

  -- provides widgets for vim.ui.select and vim.ui.input; 
  { 'stevearc/dressing.nvim', opts = {}, },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require('neo-tree').setup {
        window = {
          position = "left",
          width = 30,
          mappings = {
            ["l"] = "open",
            ["h"] = "open",
          }
        },
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
          }
        }
      }
    end,
  }
}

-- vim: ts=2 sts=2 sw=2 et
