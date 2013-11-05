" Apache log4j and log4php syntax file.
" Language:    Apache log4j/log4php log file
" Maintainer:  Andrei Nicholson <contact@andreinicholson.com>
" Last Change: 2012-07-06
" Version:     0.3
"
" While it's possible to define any sort of pattern via PatternLayout (log4j)
" or LoggerLayoutPattern (log4php), this syntax file focuses on the default
" TTCC layout TTCC layout with conversion pattern set to:
"
"     %d{m/d/y H:i:s,u} [%t] %p %c %x - %m%n

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case ignore

" First element must be abbreviated month. Could be a better way.
syn match log4jHeader    "^[0-9]\{4}.\{-} - " contains=log4jDate,log4jProcessid,log4jErrorlevel,log4jLogger
" syn match log4jDate      contained "^[0-9]\{4\}-"
syn match log4jProcessid contained "\[[0-9]*\]"
syn match log4jLogger    contained "[a-z\-.]* -"

syn case match

syn match log4jErrorlevel contained "\(DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN\)"

if version >= 508 || !exists("did_log4j_syntax_inits")
    if version < 508
        let did_log4j_syntax_inits = 1
        command! -nargs=+ HiLink hi link <args>
    else
        command! -nargs=+ HiLink hi def link <args>
    endif

    HiLink log4jDate       Type
    HiLink log4jErrorlevel Keyword
    HiLink log4jProcessid  Function
    HiLink log4jLogger     Delimiter

    delcommand HiLink
endif

let b:current_syntax = "log4j"
