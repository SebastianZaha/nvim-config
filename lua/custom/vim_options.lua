vim.o.autoread = true -- autoload file changes. undo by pressing u
vim.o.scrolloff = 7 -- cursor lines when at the top or bottom of the screen
vim.o.sidescrolloff = 5
vim.o.number = true
vim.o.relativenumber = true
vim.o.diffopt = 'internal,filler,vertical,hiddenoff,closeoff,algorithm:patience'
vim.o.splitbelow = true
vim.o.splitright = true

-- indenting and tabs related
vim.o.expandtab = true -- use spaces for indenting
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = '>>'
vim.o.breakindent = true
vim.o.breakindentopt = 'sbr,shift:4'

-- color related
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd.colorscheme 'ayu'
