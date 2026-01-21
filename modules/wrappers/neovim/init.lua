vim.g.netrw_banner = 0
vim.opt.clipboard = 'unnamedplus'
vim.opt.hidden = true
vim.opt.laststatus = 1
vim.opt.shortmess:append('I')
vim.opt.termguicolors = false

vim.api.nvim_create_augroup('highlight_override', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'highlight_override',
  pattern = '*',
  callback = function()
    vim.cmd('highlight WinSeparator ctermbg=None')
  end,
})

vim.opt.background = 'light'
vim.cmd('colorscheme simple')
