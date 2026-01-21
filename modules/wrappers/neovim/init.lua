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

-- Custom command to inspect syntax stack at current line and column
-- https://github.com/vim/colorschemes/wiki/How-to-override-a-colorscheme%3F
vim.api.nvim_create_user_command('Inspect', function()
  local syntax_stack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
  local syntax_names = {}
  for _, syn_id in ipairs(syntax_stack) do
    table.insert(syntax_names, vim.fn.synIDattr(syn_id, 'name'))
  end
  print(vim.inspect(syntax_names))
end, {})
