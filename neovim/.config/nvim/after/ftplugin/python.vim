noremap <Plug>(sort-imports) :!isort --balanced --combine-as --multi-line 3 --trailing-comma --use-parentheses %<CR>

nmap <silent> <buffer> <leader>si <Plug>(sort-imports)
