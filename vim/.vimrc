set nocompatible

" Plugin management {
    call plug#begin()
    " Plugins {
        " General {
            Plug 'vim-scripts/restore_view.vim'     " Restores cursor position and folds of reopened files

            Plug 'scrooloose/nerdtree'              " A file browser tree
            Plug 'jistr/vim-nerdtree-tabs'          " Better NERDTree integration

            Plug 'sjl/badwolf'                      " Color scheme
            Plug 'vim-airline/vim-airline'          " Status and tab bar
            Plug 'vim-airline/vim-airline-themes'   " Status and tab bar themes
            Plug 'mhinz/vim-signify'                " Difference indicator that integrates with VCS
            Plug 'myusuf3/numbers.vim'              " Toggle between relative and fixed line numbers

            " Fuzzy file finder and custom matcher specialized for paths
            Plug 'ctrlpvim/ctrlp.vim'
            Plug 'nixprime/cpsm', { 'do': './install.sh' }

            Plug 'godlygeek/tabular'                " Tabular alignment
            Plug 'Raimondi/delimitMate'             " Autoclose matching pairs of characters

            " Async execution library
            Plug 'Shougo/vimproc.vim', { 'do': 'make' }
        " }

        " General Programming {
            Plug 'PotatoesMaster/i3-vim-syntax'     " i3 config syntax highlight
            Plug 'beyondmarc/glsl.vim'              " GLSL syntax highlighting
            Plug 'ludovicchabant/vim-gutentags'     " Automatic tags management

            " Completion Engine
            Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py --clang-completer' }
            Plug 'majutsushi/tagbar'                " Source code tag browser
            Plug 'benekastah/neomake'               " Syntax checking plugin

            Plug 'SirVer/ultisnips'                 " Snippets engine
            Plug 'honza/vim-snippets'               " Actual snippets

            Plug 'plasticboy/vim-markdown'          " Markdown
        " }

        " C++ {
            Plug 'octol/vim-cpp-enhanced-highlight' " Better C++ syntax highlighting
            Plug 'rhysd/vim-clang-format'           " Clang format
        " }

        " Python {
            Plug 'klen/python-mode'                 " Better Python support
        " }

        " JSON {
            Plug 'elzr/vim-json'                    " Better JSON support
        " }

        " If there's a local plugins file then source it
        if filereadable(glob("~/.vimrc.plugins.local"))
            source ~/.vimrc.plugins.local
        endif
    " }
    call plug#end()
" }

" Settings {
    " General {
        filetype plugin indent on                     " Automatically detect file types
        set mouse=a                                   " Allow mouse usage
        set mousehide                                 " Hide the cursor while typing
        set clipboard=unnamedplus                     " Use the + register for copy-paste
        set shortmess+=filmnrxoOtT                    " Abbreviate some messages (avoids 'hit enter')
        set virtualedit=onemore                       " Allow the cursor to go beyod the last character
        set history=1000                              " Store a lot of history
        set spell                                     " Turn on the spellchecker
        set hidden                                    " Allow buffer switching without saving

        set noswapfile                                " Disable swap files
        set undodir=~/.vim/undodir                    " Set the location of the undodir
        set undofile                                  " Turn persistent undo on
        set undolevels=1000                           " Maximum number of changes to record
        set undoreload=10000                          " Maximum number lines to save for undo on a buffer reload

        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    " }

    " Appearance {
        syntax on                                     " Turn on syntax highlighting
        colorscheme badwolf

        set number                                    " Always show line numbers

        set foldenable                                " Enable folding
        set cursorline                                " Highlight current line
        set laststatus=2                              " Always display statusline
        set showmatch                                 " Show matching brackets
        set incsearch                                 " Find as you type search
        set hlsearch                                  " Highlight search terms

        " Highlight problematic whitespace
        set list
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
    " }

    " Functionality {
        set ignorecase                                " Case insensitive search
        set smartcase                                 " Case sensitive search when upper case characters are present
        set wildmenu                                  " List command completions instead of just completing
        set wildmode=list:longest,full                " Command <Tab> completion, list matches, then longest common part, then everything else
        set whichwrap=b,s,h,l,<,>,[,]                 " Backspace and cursor keys wrap too
        set scrolljump=5                              " Lines to scroll when curosr leaves screen
        set scrolloff=3                               " Minimum lines to keep above and below cursor
        set splitright                                " Puts new vsplit windows to the right of the current
        set splitbelow                                " Puts new split windows to the bottom of the current
        set ttyfast                                   " Always indicate a fast terminal connection
    " }

    " Formatting {
        set nowrap                                    " Don't wrap log lines
        set autoindent                                " Indent at the same level of previous line
        set shiftwidth=4                              " Use indents of 4 spaces
        set expandtab                                 " Insert spaces instead of tabs
        set tabstop=4                                 " Indent by 4 columns on Tab press
        set softtabstop=4                             " Let backspace delete indent
        set nojoinspaces                              " Prevents inserting two spaces after punctuation on a join
    " }

    " Vim Key (re)mappings {
        " Map leader key to space
        let mapleader="\<Space>"

        " Easier moving between splits; conflics with digraph mapping
        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h

        " Wrapped lines go down/up to next row rather than to the next line in file
        noremap j gj
        noremap k gk

        " Fix common command errors such as 'W' instead of 'w' and so on
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>

        " Visual mode shifting does not exit visual mode
        vnoremap < <gv
        vnoremap > >gv

        " For when you forget to edit the file with su permissions
        cmap w!! w !sudo tee % >/dev/null
    " }

    " Plugins {
        " Airline {
            let g:airline_powerline_fonts=1
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tabline#buffer_idx_mode = 1

            " Buffer switching shortcuts
            nmap <leader>1 <Plug>AirlineSelectTab1
            nmap <leader>2 <Plug>AirlineSelectTab2
            nmap <leader>3 <Plug>AirlineSelectTab3
            nmap <leader>4 <Plug>AirlineSelectTab4
            nmap <leader>5 <Plug>AirlineSelectTab5
            nmap <leader>6 <Plug>AirlineSelectTab6
            nmap <leader>7 <Plug>AirlineSelectTab7
            nmap <leader>8 <Plug>AirlineSelectTab8
            nmap <leader>9 <Plug>AirlineSelectTab9
        " }

        " CtrlP {
            " Only use the silver searcher to scan directories if available
            if executable('ag')
                let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden
                      \ --ignore .git
                      \ --ignore .svn
                      \ --ignore .hg
                      \ --ignore .DS_Store
                      \ --ignore "**/*.pyc"
                      \ --ignore "**/*.o"
                      \ -g ""'
                " Consider replacing with "find -H %s -path '*/.git/*' -prune -o -xtype f -print"
                " It appears to be faster than ag
            endif
            let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
        " }

        " Delimitmate
        " {
            let delimitMate_expand_cr=1
        " }

        " NERDTree {
            map <C-e> :NERDTreeTabsToggle<CR>
            let g:NERDTreeCaseSensitiveSort=1
            let g:NERDTreeIgnore=['\~$', '\pyc', '__pycache__']
            let g:NERDTreeBookmarksFile='~/.vim/NERDTreeBookmarks'
            let g:NERDTreeMouseMode=2
        " }

        " Tagbar {
            map <leader>tb :TagbarToggle<CR>
            let g:tagbar_type_markdown = {
                \ 'ctagstype': 'markdown',
                \ 'ctagsbin' : 'markdown2ctags',
                \ 'ctagsargs' : '-f - --sort=yes',
                \ 'kinds' : [
                    \ 's:sections',
                    \ 'i:images'
                \ ],
                \ 'sro' : '|',
                \ 'kind2scope' : {
                    \ 's' : 'section',
                \ },
                \ 'sort': 0,
            \ }
        " }

        " YouCompleteMe {
            " Enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files=1

            " Remap Ultisnips for compatibility with YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " GoTo Mappings
            " TODO: idea, try to jump using YCM if it fails try with tags
            map <leader>ji :YcmCompleter GoToDefinition<CR>
            map <leader>jd :YcmCompleter GoToDeclaration<CR>
        " }

        " clang-format {
            let g:clang_format#detect_style_file = 1
        " }

        " vim-cpp-enhanced-highlight {
            let g:cpp_class_scope_highlight = 1
        " }

        " Python-mode {
            " Fixes interference with YouCompleteMe
            let g:pymode_virtualenv=1                           " Autodetect virtualenv
            let g:pymode_rope = 0                               " Disable rope for now
            let g:pymode_rope_complete_on_dot = 0               " Fixes interaction with YCM
        " }

        " Tabularize {
            " Some useful shortcuts
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /=<CR>
            vmap <Leader>a= :Tabularize /=<CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        " }
    " }
" }


" Load any local configurations if available
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker :
