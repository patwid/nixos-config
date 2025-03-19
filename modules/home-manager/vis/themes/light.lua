local black1 = '#353535' -- darkerGrey
local black2 = '#555555' -- darkGrey

local white1 = '#d5d5d5' -- lighterGrey
local white2 = '#b5b5b5' -- lightGrey

local lexers = vis.lexers

lexers.STYLE_DEFAULT = 'back:white,fore:'..black1
lexers.STYLE_NOTHING = ''
lexers.STYLE_CLASS = ''
lexers.STYLE_COMMENT = 'fore:'..white2
lexers.STYLE_CONSTANT = ''
lexers.STYLE_DEFINITION = ''
lexers.STYLE_ERROR = ''
lexers.STYLE_FUNCTION = ''
lexers.STYLE_KEYWORD = 'bold'
lexers.STYLE_LABEL = ''
lexers.STYLE_NUMBER = ''
lexers.STYLE_OPERATOR = ''
lexers.STYLE_REGEX = ''
lexers.STYLE_STRING = ''
lexers.STYLE_PREPROCESSOR = ''
lexers.STYLE_TAG = ''
lexers.STYLE_TYPE = ''
lexers.STYLE_VARIABLE = ''
lexers.STYLE_WHITESPACE = ''
lexers.STYLE_EMBEDDED = ''
lexers.STYLE_IDENTIFIER = ''

lexers.STYLE_LINENUMBER = 'fore:'..white2
lexers.STYLE_LINENUMBER_CURSOR = lexers.STYLE_LINENUMBER
lexers.STYLE_CURSOR = 'back:'..white2
lexers.STYLE_CURSOR_PRIMARY = lexers.STYLE_CURSOR..',fore:'..black1
lexers.STYLE_CURSOR_LINE = 'underlined'
lexers.STYLE_COLOR_COLUMN = 'back:'..white1
lexers.STYLE_SELECTION = 'back:'..white1..',bold'
lexers.STYLE_STATUS = 'back:'..white1..',fore:'..black1
lexers.STYLE_STATUS_FOCUSED = lexers.STYLE_STATUS..',bold'
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT
lexers.STYLE_INFO = 'fore:default,back:default'
lexers.STYLE_EOF = ''

