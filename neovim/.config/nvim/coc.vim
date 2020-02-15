" Affects diagnostic messages
set updatetime=300

call coc#add_extension('coc-python', 'coc-vimlsp', 'coc-json')

function! s:is_whitespace_before_cursor() abort
  let col_idx = col('.') - 1
  return col_idx == 0 || getline('.')[col_idx - 1]  =~ '\s'
endfunction

function! s:confirm_or_select_next_completion() abort
    let ci = complete_info(['selected', 'items'])
    if ci['selected'] != -1 && len(ci["items"]) == 1
        return "\<C-y>" " Confirm completion
    endif
    return "\<C-n>" " Next completion
endfunction

" Bindings to better navigate suggestions
inoremap <expr> <C-j>   pumvisible() ? <SID>confirm_or_select_next_completion() : "\<C-j>"
inoremap <expr> <Tab>   pumvisible() ? <SID>confirm_or_select_next_completion() : "\<Tab>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Force completion on ctrl-backspace, backspace and ctrl-space
inoremap <expr> <C-H> "\<C-w>" . coc#refresh()
inoremap <expr> <BS>
        \ <SID>is_whitespace_before_cursor() ? "\<BS>"
        \                                    : "\<BS>" . coc#refresh()
inoremap <expr> <C-Space> coc#refresh()

"
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


""""""""
" TEST
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)


"""""""""
