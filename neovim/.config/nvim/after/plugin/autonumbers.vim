" Automatically toggle between (no)relativenumber intelligently

if exists("g:loaded_autonumbers")
    finish
endif
let g:loaded_autonumbers = 1

let s:exclude_filetypes = []
let s:exclude_buftypes = []

function! s:is_buffer_affected() abort
    " Has line numbers active and is not in excluded list
    return &l:number
           \ && index(s:exclude_buftypes, &l:buftype) < 0
           \ && index(s:exclude_filetypes, &l:filetype) < 0
endfunction

function! s:maybe_set_no_relative() abort
    if s:is_buffer_affected()
        setlocal norelativenumber
    endif
endfunction

function! s:maybe_set_relative() abort
    if s:is_buffer_affected()
        setlocal relativenumber
    endif
endfunction

augroup autonumbers_toggle_relative
    autocmd!
    autocmd InsertEnter,BufLeave,WinLeave,FocusLost   * :call s:maybe_set_no_relative()
    autocmd InsertLeave,BufEnter,WinEnter,FocusGained * :call s:maybe_set_relative()
augroup end
