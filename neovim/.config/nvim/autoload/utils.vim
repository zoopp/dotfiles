" Markers to look for in FindProjectRoot
let s:root_file_markers = [ '.project_root' ]
let s:root_dir_markers  = [ '.git' ]


" Return a path representing the project root or cwd if detection
" fails.
"
" To find the project root we traverse the file system up to the
" root and we look for certain files at each level. If one such file is
" found then that path is the project root.
function! utils#FindProjectRoot()
    for marker in s:root_file_markers
        let path = findfile(marker, '../;')
        if !empty(path)
            return fnamemodify(path, ':h')
        endif
    endfor

    for marker in s:root_dir_markers
        let path = finddir(marker . '/..', ';')
        if !empty(path)
            return path
        endif
    endfor

    return getcwd()
endfunction


" Return the current buffer name like so:
"   if file extension is ext1 then return <buffer_name>.ext2
"   if file extension is ext2 tehn return <buffer_name>.ext1
"   else return the buffer name
function! utils#SwitchBufferExt(ext1, ext2)
    let bufferName = expand('%:t')
    let result = substitute(bufferName, '\.' . a:ext1 . '$', '\.' . a:ext2, 'g')
    if result == bufferName
        let result = substitute(bufferName, '\.' . a:ext2 . '$', '\.' . a:ext1, 'g')
    endif
    return result
endfunction

" Switch between header and implementation files.
"   (ext1, ext2) can be either (header_extension, impl_extension)
"   or vice versa.
function! utils#SwitchHdrImpl(ext1, ext2)
    execute 'FZF -q ' utils#SwitchBufferExt(a:ext1, a:ext2) ' -e -1 -0 ' utils#FindProjectRoot()
endfunction
