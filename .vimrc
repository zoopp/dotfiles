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
            Plugin 'scrooloose/nerdtree'              " A file browser tree
            Plugin 'jistr/vim-nerdtree-tabs'          " Improvements for nerdree
            Plugin 'spf13/vim-autoclose'              " Autoclose
            Plugin 'Lokaltog/powerline', {'rtp': '/powerline/bindings/vim'} " Nicer status bar
            Plugin 'Lokaltog/vim-easymotion'          " Vimium-like behaviour in vim
            Plugin 'vim-scripts/restore_view.vim'     " Restores the cursor position
            Plugin 'mhinz/vim-signify'                " VCS changes indicator
            Plugin 'myusuf3/numbers.vim'              " Toggle between relative and fixed line numbers
            Plugin 'spf13/vim-colors'                 " Some colorschemes
            Plugin 'flazz/vim-colorschemes'           " Some more colorschemes
            Plugin 'altercation/vim-colors-solarized' " Solarized colorscheme
        " }

        " General Programming {
            Plugin 'scrooloose/syntastic'             " Syntax checking plugin
            Plugin 'majutsushi/tagbar'                " Sourcecode tag browser
        " }

        " Snippets & AutoComplete {
            Plugin 'Valloric/YouCompleteMe'           " Completion engine
            Plugin 'SirVer/ultisnips'                 " Snippets engine
            Plugin 'honza/vim-snippets'               " Actual snippets
        " }

        " Javascript {
            Plugin 'pangloss/vim-javascript'          " Better Javascript support in vim
            Plugin 'elzr/vim-json'                    " Better JSON support in vim
        " }

        " HTML {
            Plugin 'amirh/HTML-AutoCloseTag'          " Autoclose HTML tags
            Plugin 'gorodinskiy/vim-coloresque'       " CSS and HTML color preview
            Plugin 'hail2u/vim-css3-syntax'           " Add css3 syntax highlighting
        "" }

        " Haskell {
            Plugin 'dag/vim2hs'                       " Better Haskell support in vim
            Plugin 'twinside/vim-haskellFold'         " Better Haskell code folding
            Plugin 'Shougo/vimproc.vim'               " Dependency of ghcmod-vim
            Plugin 'eagletmt/ghcmod-vim'              " Better Haskell support, dependency of neco-ghc
            Plugin 'eagletmt/neco-ghc'                " Haskell code completer
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

        " We're going to use solarized as default color scheme for vim
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast='normal'
        let g:Solarized_visibility='normal'
        color solarized

        set number                                    " Always show line numbers
        highlight clear SignColumn                    " SignColumn should match background
        highlight clear LineNr                        " Same goes for line number column

        set cursorline                                " Highlight current line
        set laststatus=2                              " Always display statusline
        set showmatch                                 " Show matching brackets
        set incsearch                                 " Find as you type search
        set hlsearch                                  " Highlight search terms
    " }

    " Functionality {
        set ignorecase                                " Case insensitive search
        set smartcase                                 " Case sensitive search when upper case characters are present
        set wildmenu                                  " List command completions instead of just completing
        set wildmode=list:longest,full                " Command <Tab> completion, list matches, then longest common part, then everything else
        set whichwrap=b,s,h,l,<,>,[,]                 " Backspace and cursor keys wrap too
        set scrolljump=5                              " Lines to scroll when curosr leaves screen
        set scrolloff=3                               " Minimum lines to keep above and below cursor
        set foldenable                                " Autofold code
        set splitright                                " Puts new vsplit windows to the right of the current
        set splitbelow                                " Puts new split windows to the bottom of the current

        " Highlight problematic whitespace
        set list
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
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
        let mapleader=','

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

        " Easier moving between splitsConflics with digraph mapping of <C-K>
        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h

        " TODO: Easier moving between tabs?
        " TODO: Easier size window manipulation
        map <leader>= <C-W>=

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

        " For when you forgot to edit the file with su permissions
        cmap w!! w !sudo tee % >/dev/null
    " }

    " Plugins {
        " AutoCloseTag {
            " Make AutoCloseTag work on xml and xhtml files
            au FileType xhtml,xml ru ftplugin/html_autoclosetag.vim
        " }

        " NERDTree {
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            let g:nerdtree_tabs_open_on_gui_startup=0
            let g:NERDTreeCaseSensitiveSort=1
            let g:NERDTreeIgnore=['\~$'. '\pyc']
            let g:NERDTreeBookmarksFile='~/.vim/NERDTreeBookmarks'
            let g:NERDTreeMouseMode=2
        " }

        " Tagbar {
            map <leader>tt :TagbarToggle<CR>
        " }

        " YouCompleteMe {
            " Enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files=1

            " Remap Ultisnips for compatibility with YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
        " }

        " Syntastic {
            " C++ specific settings
            let g:syntastic_cpp_compiler_options=' -std=c++11'  " Self explanatory
            let g:syntastic_cpp_check_header=1                  " Syntax check headers as well
        " }

        " Numbers {
            let g:enable_numbers=1
        " }

        " Eclim {
            let g:EclimCompletionMethod='omnifunc'
            let g:EclimTempFilesEnable=0
            let g:EclimProjectTreeAutoOpen=1
            let g:EclimProjectTreeExpandPathOnOpen=1
            let g:EclimProjectTreeSharedInstance=1
        " }

        " Neco-ghc {
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
        " }
    " }

" }


" temporary
let g:autoclose_vim_commentmode = 1

" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker :
