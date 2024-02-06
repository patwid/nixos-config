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

let s:text_bold      = { 'cterm': 'bold' }
let s:text_underline = { 'cterm': 'underline' }

" TODO improve naming
let s:text_bg_black = { 'ctermfg': s:white, 'ctermbg': s:darker_grey }

let s:text_bg_red               = { 'ctermbg': 'red',          'ctermfg': s:darker_grey }
let s:text_bg_yellow            = { 'ctermbg': 'yellow',       'ctermfg': s:darker_grey }
let s:text_bg_lightergrey       = { 'ctermbg': s:lighter_grey, 'ctermfg': s:darker_grey }
let s:text_bg_lightestgrey      = { 'ctermbg': s:lightest_grey }

let s:text_bg_lightergrey_bold  = extendnew(s:text_bg_lightergrey, s:text_bold)
let s:text_bg_lightestgrey_bold = extendnew(s:text_bg_lightestgrey, s:text_bold)

let s:text_fg_red         = { 'ctermfg': 'red' }
let s:text_fg_green       = { 'ctermfg': 'green' }
let s:text_fg_lightgrey   = { 'ctermfg': s:light_grey }
let s:text_fg_lightergrey = { 'ctermfg': s:lighter_grey }

fun! s:highlight(group, args = {})
	exec 'highlight ' . a:group . ' ' . ['ctermfg', 'ctermbg', 'cterm']
		\ ->map({ _, val -> val .. '=' .. get(a:args, val, 'NONE') })
		\ ->join(' ')
endfun

" UI (:h highlight-groups or :h hl-GROUP)
call s:highlight('ColorColumn')
call s:highlight('Conceal')
call s:highlight('CurSearch')
call s:highlight('Cursor')
call s:highlight('CursorColumn')
call s:highlight('CursorIM')
call s:highlight('CursorLine')
call s:highlight('CursorLineFold')
call s:highlight('CursorLineNr')
call s:highlight('CursorLineSign')
call s:highlight('DiffAdd')
call s:highlight('DiffChange')
call s:highlight('DiffDelete')
call s:highlight('DiffText')
call s:highlight('Directory')
call s:highlight('EndOfBuffer')
call s:highlight('ErrorMsg')
call s:highlight('FloatBorder')
call s:highlight('FloatTitle')
call s:highlight('FoldColumn')
call s:highlight('Folded')
call s:highlight('IncSearch', s:text_bg_yellow)
call s:highlight('LineNr', s:text_fg_lightgrey)
call s:highlight('LineNrAbove')
call s:highlight('LineNrBelow')
call s:highlight('MatchParen', s:text_bg_lightergrey)
call s:highlight('ModeMsg', s:text_fg_lightgrey)
call s:highlight('MoreMsg')
call s:highlight('MsgArea')
call s:highlight('MsgSeparator')
call s:highlight('NonText', s:text_fg_lightgrey)
call s:highlight('Normal')
call s:highlight('NormalFloat')
call s:highlight('NormalNC')
call s:highlight('Pmenu', s:text_bg_lightestgrey)
call s:highlight('PmenuExtra')
call s:highlight('PmenuExtraSel')
call s:highlight('PmenuKind')
call s:highlight('PmenuKindSel')
call s:highlight('PmenuSbar')
call s:highlight('PmenuSel', s:text_bg_lightergrey_bold)
call s:highlight('PmenuThumb', s:text_bg_lightergrey)
call s:highlight('Question')
call s:highlight('QuickFixLine')
call s:highlight('Search', s:text_bg_black)
call s:highlight('SignColumn')
call s:highlight('SpecialKey')
call s:highlight('SpellBad')
call s:highlight('SpellCap')
call s:highlight('SpellLocal')
call s:highlight('SpellRare')
call s:highlight('StatusLine', s:text_bg_lightestgrey_bold)
call s:highlight('StatusLineNC', s:text_bg_lightestgrey)
call s:highlight('StatusLineTerm', s:text_bg_lightestgrey_bold)
call s:highlight('StatusLineTermNC', s:text_bg_lightestgrey)
call s:highlight('Substitute')
call s:highlight('TabLine')
call s:highlight('TabLineFill')
call s:highlight('TabLineSel')
call s:highlight('TermCursor')
call s:highlight('TermCursorNC')
call s:highlight('Title')
call s:highlight('VertSplit', s:text_bold)
call s:highlight('Visual', s:text_bg_lightergrey)
call s:highlight('VisualNOS')
call s:highlight('WarningMsg')
call s:highlight('Whitespace')
call s:highlight('WildMenu')
call s:highlight('WinBar')
call s:highlight('WinBarNC')
call s:highlight('WinSeparator')
call s:highlight('lCursor')

" Syntax (:h syntax)
call s:highlight('Comment', s:text_fg_lightgrey)
call s:highlight('Constant')
call s:highlight('Identifier')
call s:highlight('Statement', s:text_bold)
call s:highlight('PreProc', s:text_bold)
call s:highlight('Type', s:text_bold)
call s:highlight('Special', s:text_bold)
call s:highlight('Underlined', s:text_underline)
call s:highlight('Ignore')
call s:highlight('Error', s:text_bg_red)
call s:highlight('Todo', s:text_bold)

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
