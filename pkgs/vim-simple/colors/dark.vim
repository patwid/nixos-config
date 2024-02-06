set background=dark

highlight clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'dark'

let s:black         = 232 " black (0)
let s:darkest_grey  = 235
let s:darker_grey   = 238 " darkgrey (8)
let s:dark_grey     = 241
let s:light_grey    = 244
let s:lighter_grey  = 247 " lightgrey (7)
let s:lightest_grey = 250
let s:white         = 253 " white (15)

let s:text_bold = { 'cterm': 'bold' }
let s:text_underline = { 'cterm': 'underline' }

" TODO improve naming
let s:text_bg_black = { 'ctermfg': s:black, 'ctermbg': s:lighter_grey }

let s:text_bg_red = { 'ctermfg': s:lighter_grey, 'ctermbg': 'red' }
let s:text_bg_yellow = { 'ctermfg': s:darker_grey, 'ctermbg': 'yellow' }
let s:text_bg_lightergrey = { 'ctermfg': s:lighter_grey, 'ctermbg': s:darker_grey }
let s:text_bg_lightergrey_bold = extendnew(s:text_bg_lightergrey, s:text_bold)
let s:text_bg_lightestgrey = { 'ctermbg': s:darkest_grey }
let s:text_bg_lightestgrey_bold = extendnew(s:text_bg_lightestgrey, s:text_bold)

let s:text_fg_red = { 'ctermfg': 'red' }
let s:text_fg_green = { 'ctermfg': 'green' }
let s:text_fg_lightgrey = { 'ctermfg': s:dark_grey }
let s:text_fg_lightergrey = { 'ctermfg': s:darker_grey }

fun! s:highlight(group, args = {})
	exec 'highlight ' . a:group . ' ' . ['ctermfg', 'ctermbg', 'cterm']->map({ _, val -> val .. '=' .. get(a:args, val, 'NONE') })->join(' ')
endfun

" UI
call s:highlight('ColorColumn')
call s:highlight('Conceal')
call s:highlight('CursorColumn')
call s:highlight('CursorLine')
call s:highlight('CursorLineNr')
call s:highlight('DiffAdd')
call s:highlight('DiffChange')
call s:highlight('DiffDelete')
call s:highlight('DiffText')
call s:highlight('Directory')
call s:highlight('ErrorMsg')
call s:highlight('FoldColumn')
call s:highlight('Folded')
call s:highlight('IncSearch', s:text_bg_yellow)
call s:highlight('LineNr', s:text_fg_lightgrey)
call s:highlight('ModeMsg', s:text_fg_lightgrey)
call s:highlight('MoreMsg')
call s:highlight('NonText', s:text_fg_lightgrey)
call s:highlight('Pmenu', s:text_bg_lightestgrey)
call s:highlight('PmenuSbar')
call s:highlight('PmenuSel', s:text_bg_lightergrey_bold)
call s:highlight('PmenuThumb', s:text_bg_lightergrey)
call s:highlight('Question')
call s:highlight('Search', s:text_bg_black)
call s:highlight('SignColumn')
call s:highlight('SpecialKey')
call s:highlight('SpellBad')
call s:highlight('SpellCap')
call s:highlight('SpellLocal')
call s:highlight('SpellRare')
call s:highlight('StatusLine', s:text_bg_lightestgrey_bold)
call s:highlight('StatusLineNC', s:text_bg_lightestgrey)
call s:highlight('TabLine')
call s:highlight('TabLineFill')
call s:highlight('TabLineSel')
call s:highlight('TermCursor')
call s:highlight('Title')
call s:highlight('VertSplit', s:text_bold)
call s:highlight('Visual', s:text_bg_lightergrey)
call s:highlight('WarningMsg')
call s:highlight('WildMenu')

" Syntax
call s:highlight('Comment', s:text_fg_lightgrey)
call s:highlight('Constant')
call s:highlight('Cursor')
call s:highlight('DiagnosticDeprecated')
call s:highlight('DiagnosticError')
call s:highlight('DiagnosticHint')
call s:highlight('DiagnosticInfo')
call s:highlight('DiagnosticOk')
call s:highlight('DiagnosticUnderlineError')
call s:highlight('DiagnosticUnderlineHint')
call s:highlight('DiagnosticUnderlineInfo')
call s:highlight('DiagnosticUnderlineOk')
call s:highlight('DiagnosticUnderlineWarn')
call s:highlight('DiagnosticWarn')
call s:highlight('Error', s:text_bg_red)
call s:highlight('FloatShadow')
call s:highlight('FloatShadowThrough')
call s:highlight('Identifier')
call s:highlight('Ignore')
call s:highlight('MatchParen', s:text_bg_lightergrey)
call s:highlight('NvimInternalError')
call s:highlight('PreProc', s:text_bold)
call s:highlight('RedrawDebugClear')
call s:highlight('RedrawDebugComposed')
call s:highlight('RedrawDebugNormal')
call s:highlight('RedrawDebugRecompose')
call s:highlight('Special', s:text_bold)
call s:highlight('Statement', s:text_bold)
call s:highlight('Todo', s:text_bold)
call s:highlight('Type', s:text_bold)
call s:highlight('Underlined', s:text_underline)
call s:highlight('WinBar')
call s:highlight('lCursor')

" Term
call s:highlight('StatusLineTerm', s:text_bg_lightestgrey_bold)
call s:highlight('StatusLineTermNC', s:text_bg_lightestgrey)

" Diff
call s:highlight('diffAdded', s:text_fg_green)
call s:highlight('diffRemoved', s:text_fg_red)

" Vim
highlight link vimOption Normal
highlight link vimGroup Normal
highlight link vimHiGroup Normal
highlight link vimHiAttrib Normal
highlight link vimHiCTerm Normal
highlight link vimHiCtermFgBg Normal

" Resources
" - $VIMRUNTIME/colors/README.txt
" - https://vimhelp.org/syntax.txt.html#color-schemes
