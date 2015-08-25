" Environemnt {
    set nocompatible " Drop Vi comptability
" }

" Vundle & Plugin management {
    " Setup Vundle Support {
        filetype off                      " Required by Vundle while doing its stuff
        set rtp+=~/.vim/bundle/Vundle.vim " Include Vundle in runtime path
    " }

    call vundle#begin()
    " Plugins {
        Plugin 'gmarik/Vundle.vim'
        " General {
            Plugin 'bling/vim-airline'                " Nicer status bar
            Plugin 'scrooloose/nerdtree'              " A file browser tree
            Plugin 'jistr/vim-nerdtree-tabs'          " Better NERDTree integration
            Plugin 'mhinz/vim-signify'                " VCS changes indicator
            Plugin 'myusuf3/numbers.vim'              " Toggle between relative and fixed line numbers
            Plugin 'flazz/vim-colorschemes'           " Some more colorschemes

            Plugin 'Lokaltog/vim-easymotion'          " Vimium-like behaviour in vim
            Plugin 'vim-scripts/restore_view.vim'     " Restores the cursor position

            Plugin 'Shougo/vimproc.vim'               " TODO
            Plugin 'ctrlpvim/ctrlp.vim'               " Fuzzy file finder
            Plugin 'FelikZ/ctrlp-py-matcher'          " Python matcher for CtrlP (better performance)
            Plugin 'dhruvasagar/vim-table-mode'       " Easier table manipulation
            " Plugin 'ryanoasis/vim-devicons'           " Eyecandy

        " }

        " General Programming {
            Plugin 'PotatoesMaster/i3-vim-syntax'     " i3 config syntax highlight
            Plugin 'beyondmarc/glsl.vim'              " GLSL syntax highlighting
            Plugin 'octol/vim-cpp-enhanced-highlight' " Better C++ syntax highlighting

            Plugin 'Valloric/YouCompleteMe'           " Completion engine
            Plugin 'rdnetto/YCM-Generator'            " YCM extra conf generator
            Plugin 'scrooloose/syntastic'             " Syntax checking plugin
            Plugin 'majutsushi/tagbar'                " Sourcecode tag browser

            Plugin 'spf13/vim-autoclose'              " Autoclose matching pairs
            Plugin 'SirVer/ultisnips'                 " Snippets engine
            Plugin 'honza/vim-snippets'               " Actual snippets

            Plugin 'tpope/vim-fugitive'               " Vim git integration
            Plugin 'godlygeek/tabular'                " Tabular alignment
        " }

        " Python {
            Plugin 'klen/python-mode'                 " Better Python support
        " }

        " Javascript {
            Plugin 'pangloss/vim-javascript'          " Better Javascript syntax and indent
            Plugin 'elzr/vim-json'                    " Better JSON support
        " }

        " HTML {
            Plugin 'amirh/HTML-AutoCloseTag'          " Autoclose HTML tags
            Plugin 'hail2u/vim-css3-syntax'           " Add css3 syntax highlighting
            Plugin 'gorodinskiy/vim-coloresque'       " CSS and HTML color preview
        " }
    " }
    call vundle#end()
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
        set background=dark                           " Assume a dark background
        colorscheme badwolf

        set number                                    " Always show line numbers
        highlight clear SignColumn                    " SignColumn should match background
        highlight clear LineNr                        " Same goes for line number column

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

        " Disable arrow keys in normal mode
        map <up> <nop>
        map <down> <nop>
        map <left> <nop>
        map <right> <nop>

        " Disable arrow keys in insert mode
        imap <up> <nop>
        imap <down> <nop>
        imap <left> <nop>
        imap <right> <nop>

        " Disable arrow keys in visual mode
        vmap <up> <nop>
        vmap <down> <nop>
        vmap <left> <nop>
        vmap <right> <nop>

        " Easier moving between splits; conflics with digraph mapping of <C-K>
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
            " Don't limit the index size, custom searcher, custom matcher
            let g:ctrlp_max_files=0
            let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
                  \ --ignore .git
                  \ --ignore .svn
                  \ --ignore .hg
                  \ --ignore .DS_Store
                  \ --ignore "**/*.pyc"
                  \ --ignore "**/*.o"
                  \ -g ""'
            let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
        " }

        " AutoCloseTag {
            " Make AutoCloseTag work on xml and xhtml files
            au FileType xhtml,xml ru ftplugin/html_autoclosetag.vim  
        " }

        " NERDTree {
            map <C-e> :NERDTreeTabsToggle<CR>
            let g:NERDTreeCaseSensitiveSort=1
            let g:NERDTreeIgnore=['\~$', '\pyc', '__pycache__']
            let g:NERDTreeBookmarksFile='~/.vim/NERDTreeBookmarks'
            let g:NERDTreeMouseMode=2
        " }

        " Numbers {
            let g:enable_numbers=1
        " }

        " Tagbar {
            map <leader>tb :TagbarToggle<CR>
        " }

        " YouCompleteMe {
            " Enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files=1

            " Remap Ultisnips for compatibility with YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

            " GoTo Mappings
            map <leader>ji :YcmCompleter GoToDefinition<CR>
            map <leader>jd :YcmCompleter GoToDeclaration<CR>
        " }

        " vim-cpp-enhanced-highlight {
            let g:cpp_class_scope_highlight = 1
        " }

        " Syntastic {
            " C++ specific settings
            let g:syntastic_cpp_compiler_options=' -std=c++11'
            let g:syntastic_cpp_check_header=1
            let g:syntastic_python_flake8_args='--ignore=E501,E221'
        " }

        " Python-mode {
            " Fixes interference with YouCompleteMe
            let g:pymode=1
            let g:pymode_virtualenv=1                           " Autodetect virtualenv
            let g:pymode_lint_write=0
            let g:pymode_rope = 0                               " Disable rope for now
            let g:pymode_rope_complete_on_dot = 0               " Fixes interaction with YCM
        " }

        " Tabularize {
            " nmap <Leader>a& :Tabularize /&<CR>
            " vmap <Leader>a& :Tabularize /&<CR>
            " nmap <Leader>a= :Tabularize /=<CR>
            " vmap <Leader>a= :Tabularize /=<CR>
            " nmap <Leader>a: :Tabularize /:<CR>
            " vmap <Leader>a: :Tabularize /:<CR>
            " nmap <Leader>a:: :Tabularize /:\zs<CR>
            " vmap <Leader>a:: :Tabularize /:\zs<CR>
            " nmap <Leader>a, :Tabularize /,<CR>
            " vmap <Leader>a, :Tabularize /,<CR>
            " nmap <Leader>a,, :Tabularize /,\zs<CR>
            " vmap <Leader>a,, :Tabularize /,\zs<CR>
            " nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            " vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        " }
    " }
" }


" temporary
let g:autoclose_vim_commentmode = 1

" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker :
