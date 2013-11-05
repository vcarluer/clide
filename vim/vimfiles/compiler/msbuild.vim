" Vim compiler file
" Compiler:	msbuild
" Maintainer:	Vincent Carluer
" Last Change:	2013 June 10

if exists("current_compiler")
  finish
endif
let current_compiler = "msbuild"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" default errorformat
CompilerSet errorformat=%f(%l\\,%c):\error\CS%n:\%m 

" default make
CompilerSet makeprg=msbuild\ /nologo\ /m\ /v:q\ /property:GenerateFullPaths=true
