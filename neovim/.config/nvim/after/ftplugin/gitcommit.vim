" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
"
call setpos('.', [0, 1, 1, 0])
