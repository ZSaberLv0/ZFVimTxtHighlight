" ZFVimTxtHighlight.vim - vim script to highlight plain text files
" Author:  ZSaberLv0 <http://zsaber.com/>

function! ZF_VimTxtHighlightToggle()
    if &syntax=='zftxt'
        if exists('b:ZFVimTxtHighlight_syntaxSaved')
            let &syntax=b:ZFVimTxtHighlight_syntaxSaved
        endif
    else
        let b:ZFVimTxtHighlight_syntaxSaved=&syntax
        set syntax=zftxt
    endif
    echo &syntax
endfunction

function! s:autoApply()
    if !get(g:, 'zf_txt_auto_highlight', 1)
        return
    endif
    if index(get(g:, 'zf_txt_auto_syntax', [
                \   '',
                \   'txt',
                \   'text',
                \ ]), &syntax) < 0 && &syntax != 'zftxt'
        return
    endif

    let largeFile = get(g:, 'zf_txt_large_file', 5 * 1024 * 1024)
    if largeFile > 0 && getfsize(expand('<afile>')) > largeFile
        if &syntax == 'zftxt'
            syntax clear
        endif
        return
    endif
    let largeColumn = get(g:, 'zf_txt_large_column', 1000)
    if largeColumn > 0 && filereadable(expand('<afile>'))
        for line in readfile(expand('<afile>'), '', get(g:, 'zf_txt_large_column_checklines', 5))
            if len(line) >= largeColumn
                if &syntax == 'zftxt'
                    syntax clear
                endif
                return
            endif
        endfor
    endif

    if &syntax != 'zftxt'
        let b:ZFVimTxtHighlight_syntaxSaved=&syntax
        set syntax=zftxt
    endif
endfunction

augroup ZF_VimTxtHighlight_auto
    call s:autoApply()
    autocmd!
    autocmd BufNewFile,BufReadPost,BufWritePost * call s:autoApply()
augroup END

function! ZF_VimTxtHighlightEcho()
    echo 'hi<' . synIDattr(synID(line('.'), col('.'), 1), 'name') . '> trans<'
                \ . synIDattr(synID(line('.'), col('.'), 0), 'name') . '> lo<'
                \ . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'
endfunction
command! -nargs=0 ZFHIGHLIGHT :call ZF_VimTxtHighlightEcho()

