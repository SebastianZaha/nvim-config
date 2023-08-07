vim.keymap.set({'n', 'v'}, ';', ':')
vim.keymap.set({'n', 'v'}, ':', ';')

-- <c-s> saves the buffer, optionally exiting insert mode too
vim.keymap.set('n', '<c-s>', ':update<cr>')
vim.keymap.set('i', '<c-s>', '<c-o>:update<cr><esc>')

-- q closes widows
vim.keymap.set('n', 'Q', 'q')
vim.keymap.set('n', 'q', '<esc>:q<cr>')
-- closing the buffer without messing up the window layout
vim.keymap.set('n', '<c-w>b', ':Bdelete<cr>')

-- To use ALT+{h,j,k,l} to navigate window layout from any mode
if 'Darwin' == vim.loop.os_uname().sysname then
  vim.keymap.set({'i', 't', 'n'}, '˙', '<c-\\><c-N><c-W>h')
  vim.keymap.set({'i', 't', 'n'}, '∆', '<c-\\><c-N><c-W>j')
  vim.keymap.set({'i', 't', 'n'}, '˚', '<c-\\><c-N><c-W>k')
  vim.keymap.set({'i', 't', 'n'}, '¬', '<c-\\><c-N><c-W>l')
else
  vim.keymap.set({'i', 't', 'n'}, '<a-h>', '<c-\\><c-N><c-W>h')
  vim.keymap.set({'i', 't', 'n'}, '<a-j>', '<c-\\><c-N><c-W>j')
  vim.keymap.set({'i', 't', 'n'}, '<a-k>', '<c-\\><c-N><c-W>k')
  vim.keymap.set({'i', 't', 'n'}, '<a-l>', '<c-\\><c-N><c-W>l')
end

-- [G]it
vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>')
vim.keymap.set('n', '<Leader>ga', ':Git blame<CR>')
vim.keymap.set('n', '<Leader>gl', ':Git l<CR><C-w>T')
vim.keymap.set('n', '<Leader>gp', ':Git push<CR>')
vim.keymap.set('n', '<leader>gs', ':G<CR><C-w>T')
vim.keymap.set('n', '<leader>gw', ':GBrowse<CR>')

-- terminal
vim.keymap.set('t', '<a-esc>', '<c-\\><c-N>')

-- telescope = [S]earch
-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')
local themes  = require('telescope.themes')

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>s/',  builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[Search] existing [B]uffers' })
vim.keymap.set('n', '<leader>s?', builtin.oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>s;', builtin.command_history, { desc = '[S]earch Commands' })
vim.keymap.set('n', '<leader>s.',
  function() builtin.current_buffer_fuzzy_find(themes.get_dropdown({previewer = false})) end,
  { desc = 'Fuzzily search in current buffer' })

-- gitsigns [H]unk bindings
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
