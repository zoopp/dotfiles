" Affects diagnostic messages
set updatetime=300
set signcolumn=yes
set nobackup
set nowritebackup
set hidden

call coc#add_extension('coc-emoji')
call coc#add_extension(
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
\)

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

" Function text objects
xmap <silent> if <Plug>(coc-funcobj-i)
xmap <silent> af <Plug>(coc-funcobj-a)
omap <silent> if <Plug>(coc-funcobj-i)
omap <silent> af <Plug>(coc-funcobj-a)

" Functionality
vmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f <Plug>(coc-format-selected)

nmap <silent>         ]e <Plug>(coc-diagnostic-next)
nmap <silent>         [e <Plug>(coc-diagnostic-prev)

nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>ji <Plug>(coc-implementation)
nmap <silent> <leader>jr <Plug>(coc-references)
nmap <silent> <leader>jt <Plug>(coc-type-definition)

nmap <silent> <leader>ac  <Plug>(coc-codeaction)
nmap <silent> <leader>al  <Plug>(coc-codelens-codeaction)
nmap <silent> <leader>af  <Plug>(coc-fix-current)
nmap <silent> <leader>are <Plug>(coc-refactor)
nmap <silent> <leader>ar  <Plug>(coc-rename)

nmap <silent> <leader>gd :<C-u>call CocActionAsync('doHover')<CR>

nmap <silent> <leader>la :<C-u>CocList actions<CR>
nmap <silent> <leader>lc :<C-u>CocList commands<CR>
nmap <silent> <leader>ld :<C-u>CocList --normal --auto-preview diagnostics<CR>
nmap <silent> <leader>ls :<C-u>CocList --interactive --auto-preview symbols<CR>
nmap <silent> <leader>lre :<C-u>CocListResume<CR>

" Autocmds
augroup cocstuff
    autocmd!
    " autocmd CursorHold * silent call CocActionAsync('highlight')
    " autocmd CursorHold * silent call CocActionAsync('doHover')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
