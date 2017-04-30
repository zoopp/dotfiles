
map <leader>s :call utils#SwitchHdrImpl('cpp', 'hpp')<CR>

" Add colon to keyword list. Makes <cword> to also include colon in expansions.
" Useful for code navigation when using tags (i.e. <C-]> will include class
" name).
" setlocal iskeyword+=:
