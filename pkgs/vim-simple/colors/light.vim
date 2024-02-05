set background=light

highlight clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'light'

let s:black         = 232 " black (0)
let s:darkest_grey  = 235
let s:darker_grey   = 238 " darkgrey (8)
let s:dark_grey     = 241
let s:light_grey    = 244
let s:lighter_grey  = 247 " lightgrey (7)
let s:lightest_grey = 250
let s:white         = 253 " white (15)

"highlight text_bg_red ctermfg=white ctermbg=red
"highlight text_bg_yellow ctermfg=black ctermbg=yellow
"highlight text_bg_lightergrey ctermfg=black ctermbg=lightgrey
"highlight text_bg_lightergrey_bold ctermfg=black ctermbg=lightgrey cterm=bold
"highlight text_bg_lightestgrey ctermbg=250
"highlight text_bg_lightestgrey_bold ctermbg=250 cterm=bold
"
"highlight text_fg_red ctermfg=red
"highlight text_fg_green ctermfg=green
"highlight text_fg_lightgrey ctermfg=244
"highlight text_fg_lightergrey ctermfg=lightgrey
"
"highlight text_bold cterm=bold
"highlight text_underline cterm=underline

let s:text_bold = { 'cterm': 'bold' }
let s:text_underline = { 'cterm': 'underline' }

" TODO improve naming
let s:text_bg_black = { 'ctermfg': s:white, 'ctermbg': s:darker_grey }

let s:text_bg_red = { 'ctermfg': s:darker_grey, 'ctermbg': 'red' }
let s:text_bg_yellow = { 'ctermfg': s:darker_grey, 'ctermbg': 'yellow' }
let s:text_bg_lightergrey = { 'ctermfg': s:darker_grey, 'ctermbg': s:lighter_grey }
let s:text_bg_lightergrey_bold = extendnew(s:text_bg_lightergrey, s:text_bold)
let s:text_bg_lightestgrey = { 'ctermbg': s:lightest_grey }
let s:text_bg_lightestgrey_bold = extendnew(s:text_bg_lightestgrey, s:text_bold)

let s:text_fg_red = { 'ctermfg': 'red' }
let s:text_fg_green = { 'ctermfg': 'green' }
let s:text_fg_lightgrey = { 'ctermfg': s:light_grey }
let s:text_fg_lightergrey = { 'ctermfg': s:lighter_grey }

fun! Highlight(group, type = {})
	exec 'highlight ' . a:group . ' ' . join(map(['ctermfg', 'ctermbg', 'cterm'], { _, val -> val .. '=' .. get(a:type, val, 'NONE') }), ' ')
endfun

" UI
call Highlight('ColorColumn')
call Highlight('Conceal')
call Highlight('CursorColumn')
call Highlight('CursorLine')
call Highlight('CursorLineNr')
call Highlight('DiffAdd')
call Highlight('DiffChange')
call Highlight('DiffDelete')
call Highlight('DiffText')
call Highlight('Directory')
call Highlight('ErrorMsg')
call Highlight('FoldColumn')
call Highlight('Folded')
call Highlight('IncSearch', s:text_bg_yellow)
call Highlight('LineNr', s:text_fg_lightgrey)
call Highlight('ModeMsg', s:text_fg_lightgrey)
call Highlight('MoreMsg')
call Highlight('NonText', s:text_fg_lightgrey)
call Highlight('Pmenu', s:text_bg_lightestgrey)
call Highlight('PmenuSbar')
call Highlight('PmenuSel', s:text_bg_lightergrey_bold)
call Highlight('PmenuThumb', s:text_bg_lightergrey)
call Highlight('Question')
call Highlight('Search', s:text_bg_black)
call Highlight('SignColumn')
call Highlight('SpecialKey')
call Highlight('SpellBad')
call Highlight('SpellCap')
call Highlight('SpellLocal')
call Highlight('SpellRare')
call Highlight('StatusLine', s:text_bg_lightestgrey_bold)
call Highlight('StatusLineNC', s:text_bg_lightestgrey)
call Highlight('TabLine')
call Highlight('TabLineFill')
call Highlight('TabLineSel')
call Highlight('TermCursor')
call Highlight('Title')
call Highlight('VertSplit', s:text_bold)
call Highlight('Visual', s:text_bg_lightergrey)
call Highlight('WarningMsg')
call Highlight('WildMenu')

" Syntax
call Highlight('Comment', s:text_fg_lightgrey)
call Highlight('Constant')
call Highlight('Cursor')
call Highlight('DiagnosticDeprecated')
call Highlight('DiagnosticError')
call Highlight('DiagnosticHint')
call Highlight('DiagnosticInfo')
call Highlight('DiagnosticOk')
call Highlight('DiagnosticUnderlineError')
call Highlight('DiagnosticUnderlineHint')
call Highlight('DiagnosticUnderlineInfo')
call Highlight('DiagnosticUnderlineOk')
call Highlight('DiagnosticUnderlineWarn')
call Highlight('DiagnosticWarn')
call Highlight('Error', s:text_bg_red)
call Highlight('FloatShadow')
call Highlight('FloatShadowThrough')
call Highlight('Identifier')
call Highlight('Ignore')
call Highlight('MatchParen', s:text_bg_lightergrey)
call Highlight('NvimInternalError')
call Highlight('PreProc', s:text_bold)
call Highlight('RedrawDebugClear')
call Highlight('RedrawDebugComposed')
call Highlight('RedrawDebugNormal')
call Highlight('RedrawDebugRecompose')
call Highlight('Special', s:text_bold)
call Highlight('Statement', s:text_bold)
call Highlight('Todo', s:text_bold)
call Highlight('Type', s:text_bold)
call Highlight('Underlined', s:text_underline)
call Highlight('WinBar')
call Highlight('lCursor')

" Term
call Highlight('StatusLineTerm', s:text_bg_lightestgrey_bold)
call Highlight('StatusLineTermNC', s:text_bg_lightestgrey)

" Diff
call Highlight('diffAdded', s:text_fg_green)
call Highlight('diffRemoved', s:text_fg_red)

" Vim
highlight link vimOption Normal
highlight link vimHiGroup Normal
highlight link vimGroup Normal
highlight link vimHiAttrib Normal
highlight link vimHiCTerm Normal
highlight link vimHiCtermFgBg Normal

" Resources
" - $VIMRUNTIME/colors/README.txt
" - https://vimhelp.org/syntax.txt.html#color-schemes
