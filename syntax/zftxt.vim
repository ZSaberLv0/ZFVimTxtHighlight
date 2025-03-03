if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn cluster zftxtContainsExceptString add=zftxtEscapedChar
syn cluster zftxtContainsExceptString add=zftxtFunc
syn cluster zftxtContainsExceptString add=zftxtLink
syn cluster zftxtContainsExceptString add=zftxtMark
syn cluster zftxtContainsExceptString add=zftxtNumber
syn cluster zftxtContainsExceptString add=zftxtOption
syn cluster zftxtContainsExceptString add=zftxtPreProc
syn cluster zftxtContainsExceptString add=zftxtTag
syn cluster zftxtContainsExceptString add=zftxtType
syn cluster zftxtContainsExceptString add=zftxtVar

syn cluster zftxtContains add=zftxtContainsExceptString
syn cluster zftxtContains add=zftxtString

" ============================================================
syn match zftxtNormal "[[:alpha:]]" contains=@zftxtOperator

" ============================================================
" [~\-\+\*\(\)\[\]\{\}<>=\|#@\$%&\\\/:;&\^,!\?]
syn match zftxtOperator "[~\-+\*()[\]{}<>=|#@\$%&\\\/:;&\^,!?]"

" ============================================================
" //xxx
" \/{2,}.*$
syn match zftxtComments "/\{2,}.*$" contains=@zftxtContains
" # xxx
" ^[ \t]*#+[ \t]+.*$
syn match zftxtComments "^[ \t]*#\+[ \t]\+.*$" contains=@zftxtContains
" single # in one line
" ^[ \t]*#+[ \t]*$
syn match zftxtComments "^[ \t]*#\+[ \t]*$" contains=@zftxtContains
" vim's comment
" ^[ \t]*"[^"]*$
syn match zftxtComments '^[ \t]*"[^"]*$' contains=@zftxtContains
" rem[ark] xxx
" rem((a)|(ar)|(ark))?[ \t]+.*$
syn match zftxtComments "rem\(\(a\)\|\(ar\)\|\(ark\)\)\=[ \t]\+.*$" contains=@zftxtContains
" /*xxx*/
" \/\*+
" \*+\/
syn region zftxtComments start="/\*\+" end="\*\+/" contains=@zftxtContains
" <!--xxx-->
" <!--
" -->
syn region zftxtComments start="<!--" end="-->" contains=@zftxtContains

" ============================================================
" \x
" \\.
syn match zftxtEscapedChar "\\."

" ============================================================
" <Abc_123[ xxx]>
" <[\?\/]?(?!php)[_a-zA-Z][_a-zA-Z0-9]*
" [\?\/]?>
syn region zftxtTag start="<[?\/]\=\%(php\)\@![_a-zA-Z][_a-zA-Z0-9]*" end="[?\/]\=>" contains=@zftxtContains

" ============================================================
" $Abc_123
" \$+[_a-zA-Z0-9]+
syn match zftxtVar "\$\+[_a-zA-Z0-9]\+"
" $([xxx])
" \$+\([^\(\)]*\)
syn match zftxtVar "\$\+([^()]*)" contains=@zftxtContains
" ${[xxx]}
" \$+\{[^\{\}]*\}
syn match zftxtVar "\$\+{[^{}]*}" contains=@zftxtContains
" %Abc_123%
" %+[_a-zA-Z0-9]+%*
syn match zftxtVar "%\+[_a-zA-Z0-9]\+%*"
" %([xxx])%
" %+\([^\(\)]*\)%*
syn match zftxtVar "%\+([^()]*)%*" contains=@zftxtContains
" %{[xxx]}%
" %+\{[^\{\}]*\}%*
syn match zftxtVar "%\+{[^{}]*}%*" contains=@zftxtContains

" ============================================================
syn region zftxtString start=/"/ end=/"/ end=/$/ skip=/\\./ contains=@zftxtContainsExceptString
syn region zftxtString start=/'\(s \|t \| \w\)\@!/ end=/'/ end=/$/ end=/s / skip=/\\./ contains=@zftxtContainsExceptString
syn region zftxtString start=/`/ end=/`/ end=/$/ skip=/\\./ contains=@zftxtContainsExceptString
syn region zftxtString start=/“/ end=/”/ end=/$/ skip=/\\./ contains=@zftxtContainsExceptString
syn region zftxtString start=/‘/ end=/’/ end=/$/ skip=/\\./ contains=@zftxtContainsExceptString

" ============================================================
" 0xAbcd1234
" \<(0[xX])?[a-fA-F0-9]{8,}\>
syn match zftxtNumber "\<\(0[xX]\)\=[a-fA-F0-9]\{8,}\>"
" #123Abc
" #[a-fA-F0-9]{6,}\>
syn match zftxtNumber "#[a-fA-F0-9]\{6,}\>"
" Abc:123.Xyz-alpha
" \<([a-zA-Z_\-\.:]*[0-9]+)+\.[a-zA-Z_\-\.:]*\>
syn match zftxtNumber "\<\([a-zA-Z_\-\.:]*[0-9]\+\)\+\.[a-zA-Z_\-\.:]*\>"

" ============================================================
" -Abc_123[=xxx]
" (([ \t])|^)--?[a-zA-Z0-9_\-]+[a-zA-Z0-9_\-=]*\>
syn match zftxtOption "\(\([ \t]\)\|^\)--\=[a-zA-Z0-9_\-]\+[a-zA-Z0-9_\-=]*\>"

" ============================================================
" ABC_123[=123]
" \<[_\-A-Z0-9]*[A-Z]{2,}[_A-Z0-9]*\>(?=([ \t]*=[ \t]*[^ \t]+)?)
syn match zftxtPreProc "\<[_\-A-Z0-9]*[A-Z]\{2,}[_A-Z0-9]*\>\%(\([ \t]*=[ \t]*[^ \t]\+\)\=\)\@="
" #abc
" #[a-z]{2,}\>
syn match zftxtPreProc "#[a-z]\{2,}\>"
" @Abc_123
" (?<=([ \t])|^)@[a-zA_Z0-9_\.]{2,}
syn match zftxtPreProc "\%(\([ \t]\)\|^\)\@<=@[a-zA_Z0-9_\.]\{2,}"

" ============================================================
" Abc_123:xxx#xxx<xxx>()
" [_a-zA-Z][_a-zA-Z0-9#:]*([ \t]*<.*>)?(?=[ \t]*\()
syn match zftxtFunc "[_a-zA-Z][_a-zA-Z0-9#:]*\([ \t]*<.*>\)\=\%([ \t]*(\)\@="

" ============================================================
" Abc_123[:xxx]
" ([_a-zA-Z][_a-zA-Z0-9]*)?([ \t]*::[ \t]*[_a-zA-Z][_a-zA-Z0-9]*)+
syn match zftxtType "\([_a-zA-Z][_a-zA-Z0-9]*\)\=\([ \t]*::[ \t]*[_a-zA-Z][_a-zA-Z0-9]*\)\+"

" ============================================================
" Abc_123-Xyz://[xxx]
" [a-zA-Z0-9_\-]+:\/\/[a-zA-Z0-9~!@#\$%\^&\*\-_=\+\\\|;:,\.\/\?]*
syn match zftxtLink "[a-zA-Z0-9_\-]\+:\/\/[a-zA-Z0-9~!@#\$%\^&\*\-_=+\\|;:,\.\/?]*"
" abc_123-.abc_123-.abc_123-
" \<[a-z0-9_\-]+(\.[a-z0-9_\-]+){2,}[a-z0-9~!@#\$%\^&\*\-_=\+\\\|;:,\.\/\?]*\>
syn match zftxtLink "\<[a-z0-9_\-]\+\(\.[a-z0-9_\-]\+\)\{2,}[a-z0-9~!@#\$%\^&\*\-_=+\\|;:,\.\/?]*\>"
" xxx@xxx
" [a-zA-Z0-9_\-\.]+@[a-zA-Z0-9_\-\.]+
syn match zftxtLink "[a-zA-Z0-9_\-\.]\+@[a-zA-Z0-9_\-\.]\+"

syn case ignore
syn keyword zftxtMark todo fixme note warning
syn case match

syn case ignore
syn keyword zftxtKeyword if else elseif elif endif fi end
syn keyword zftxtKeyword switch case default break
syn keyword zftxtKeyword for endfor foreach for_each while endwhile until
syn keyword zftxtKeyword function endfunction return
syn keyword zftxtKeyword try endtry catch finally
syn keyword zftxtKeyword static const virtual final native readonly
syn keyword zftxtKeyword class struct interface public protected private friend extend extends
syn keyword zftxtKeyword this self
syn keyword zftxtKeyword void null nil int char string long bool boolean float double
syn keyword zftxtKeyword let set var local
syn keyword zftxtKeyword export import include require
syn keyword zftxtKeyword call command
syn keyword zftxtKeyword true false yes no
syn keyword zftxtKeyword new delete
syn keyword zftxtKeyword use using namespace
syn case match

hi def link zftxtComments Comment
hi def link zftxtFunc Function
hi def link zftxtKeyword Keyword
hi def link zftxtLink Underlined
hi def link zftxtMark Todo
hi def link zftxtNormal Normal
hi def link zftxtNumber Constant
hi def link zftxtOperator Operator
hi def link zftxtOption Define
hi def link zftxtPreProc PreProc
hi def link zftxtEscapedChar SpecialChar
hi def link zftxtString String
hi def link zftxtTag Tag
hi def link zftxtType Typedef
hi def link zftxtVar Identifier

let b:current_syntax = "zftxt"

for f in split(globpath(&rtp, 'zftxt/*.vim'), "\n")
    execute 'source ' . fnameescape(f)
endfor

