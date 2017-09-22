"============================================================================
"File:        freepascal.vim
"Description: Syntax checking plugin for syntastic
"Maintainer:  Marc Hanisch <marc.hanisch at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_freepascal_fpc_checker')
    finish
endif
let g:loaded_syntastic_freepascal_fpc_checker = 1

let s:save_cpo = &cpo
set cpo&vim

"function! SyntaxCheckers_freepascal_fpc_GetHighlightRegex(item)
"    let term = matchstr(a:item['text'], '\mLocal variable "\zs\S\+\ze" not used')
"    return term !=# '' ? '\V' . escape(term, '\') : ''
"endfunction

function! SyntaxCheckers_freepascal_fpc_IsAvailable() dict
    if !exists('g:syntastic_freepascal_compiler')
        let g:syntastic_freepascal_compiler = self.getExec()
    endif
    return executable(expand(g:syntastic_freepascal_compiler, 1))
endfunction

function! SyntaxCheckers_freepascal_fpc_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'args': '-FE"/tmp"'})

    let errorformat =
        \ '%f(%l\,%v)\ %trror:\ %m,'.
        \ '%E%f(%l\,%v)\ fatal:\ %m,'.
        \ '%f(%l\,%v)\ %tarn:\ %m,'.
        \ '%I%f(%l\,%c)\ note:\ %m,'.
        \ '%I%f(%l\,%c)\ hint:\ %m,'.
        \ '%-G%>%f(%l\,%c)\ %s\, stopping'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'postprocess': ['guards'] })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'freepascal',
    \ 'name': 'fpc'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
