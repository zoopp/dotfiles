"
" Some constants pointing to local configuration files
"
let s:local_plugins_path = '~/.config/nvim/local.plugins.vim'
let s:local_init_path = '~/.config/nvim/local.init.vim'


"
" Don't rely on the neovim python client to be installed in a virtualenv
"
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'


" Plugins {
  call plug#begin()
    " General {
      Plug 'morhetz/gruvbox'                      " Color scheme
      Plug 'myusuf3/numbers.vim'                  " Toggle between relative and fixed line numbers
      Plug 'vim-airline/vim-airline'              " Status and tab bar

      " A file browser tree & a git plugin to go along
      Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
      Plug 'scrooloose/nerdtree',         { 'on': 'NERDTreeToggle' }

      " Fuzzy finder + vim integration
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'

      " Misc
      Plug 'godlygeek/tabular'                    " Tabular alignment
      Plug 'kopischke/vim-stay'                   " Automatic view creation and restoration
    " }

    " General Programming {
      " Syntax {
        Plug 'PotatoesMaster/i3-vim-syntax'       " i3 config syntax highlight
        Plug 'beyondmarc/glsl.vim'                " GLSL syntax highlighting
        Plug 'sophacles/vim-bundle-mako'          " Mako syntax highlighting
      " }

      " Code {
        Plug 'SirVer/ultisnips'                   " Snippets engine
        Plug 'majutsushi/tagbar'                  " Source code tag browser
      " }

      " Misc {
        Plug 'Raimondi/delimitMate'               " Auto close matching pairs of characters
        Plug 'mhinz/vim-signify'                  " Gutter diff indicator that integrates with VCSs
      " }
    " }

    " C++ {
      Plug 'octol/vim-cpp-enhanced-highlight'     " Better C++ syntax highlighting
      Plug 'rhysd/vim-clang-format'               " Clang format
      Plug 'richq/vim-cmake-completion', {'for': 'cmake'}
    " }

    " Markdown {
      Plug 'plasticboy/vim-markdown'              " Markdown integration
    " }

    " Python {
      Plug 'klen/python-mode'                     " Better Python support
    " }

    " ReStructuredText {
      Plug 'Rykka/InstantRst', {'for': 'rst'}     " Preview rst docs on-the-fly in the browser
      Plug 'Rykka/riv.vim',    {'for': 'rst'}     " ReStructuredText integration
    " }

    " JSON {
      Plug 'elzr/vim-json'                        " Better JSON support
    " }

    " UML {
      Plug 'aklt/plantuml-syntax'                 " PlatUML syntax support
    " "

    " If there's a local plugins file then source it
    if filereadable(expand(s:local_plugins_path))
        execute 'source ' . s:local_plugins_path
    endif
  call plug#end()
" }

" Settings {
  " General settings {
    set clipboard=unnamedplus                     " Use the + register for copy-paste
    set hidden                                    " Allow buffer switching without saving
    set history=1000                              " Store a lot of history
    set lazyredraw                                " Redraw only when we need to
    set noswapfile                                " Disable swap files
    set shortmess+=filmnrxoOtT                    " Abbreviate some messages (avoids 'hit enter')
    set showcmd                                   " Show partial command in the last line of the screen
    set spell                                     " Turn on the spell checker
    set undofile                                  " Turn persistent undo on
    set undolevels=10000                          " Maximum number of changes to record
    set undoreload=10000                          " Maximum number lines to save for undo on a buffer reload
    set viewoptions=cursor,folds,slash,unix       " What info to store when saving view info
    set virtualedit=onemore                       " Allow the cursor to go beyond the last character
  " }

  " Appearance {
    set termguicolors                             " Enable true color support

    let g:gruvbox_contrast_dark="hard"
    set background=dark
    colorscheme gruvbox

    set cursorline                                " Highlight current line
    set foldenable                                " Enable folding
    set hlsearch                                  " Highlight search terms
    set incsearch                                 " Find as you type search
    set laststatus=2                              " Always display statusline
    set number                                    " Always show line numbers
    set showmatch                                 " Show matching brackets

    " Highlight problematic whitespace
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
  " }

  " Functionality {
    set ignorecase                                " Case insensitive search
    set inccommand=nosplit                        " Show incremental effects of substitution commands
    set mouse=a                                   " Enable mouse usage for when we get lazy
    set scrolljump=5                              " Lines to scroll when cursor leaves screen
    set scrolloff=3                               " Minimum lines to keep above and below cursor
    set smartcase                                 " Case sensitive search when upper case characters are present
    set splitbelow                                " Puts new split windows to the bottom of the current
    set splitright                                " Puts new vsplit windows to the right of the current
    set tags=./tags;/                             " Look for a tags file upwards until found
    set whichwrap=b,s,h,l,<,>,[,]                 " Backspace and cursor keys wrap too
    set wildmenu                                  " List command completions instead of just completing
    set wildmode=list:longest,full                " Command <Tab> completion, list matches, then longest common part, then everything else
  " }

  " Formatting {
    set expandtab                                 " Insert spaces instead of tabs
    set nojoinspaces                              " Prevents inserting two spaces after punctuation on a join
    set nowrap                                    " Don't wrap long lines
    set shiftround                                " Round indent to multiple of 'shiftwidth'
    set shiftwidth=4                              " Use indents of 4 spaces
    set softtabstop=4                             " Let backspace delete indent
    set tabstop=4                                 " Indent by 4 columns on Tab press
  " }

  " General keybinds {
    " Map leader key to space
    let mapleader="\<Space>"

    " Easier moving between splits; conflict with digraph mapping.
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    " Open man page 3 for word under cursor
    nmap <leader>m :Man 3 <C-R><C-W><CR>

    " Wrapped lines go down/up to next row rather than to the next line in file
    noremap j gj
    noremap k gk

    " Visual mode shifting does not exit visual mode
    vnoremap < <gv
    vnoremap > >gv

    " Make arrow keys do something useful
    nnoremap <Left> :vertical resize +2<CR>
    nnoremap <Right> :vertical resize -2<CR>
    nnoremap <Up> :resize -2<CR>
    nnoremap <Down> :resize +2<CR>
  " }

  " General commands {
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

    " clang-format {
      let g:clang_format#detect_style_file = 1
    " }

    " Delimitmate {
      let delimitMate_expand_cr=1
    " }

    " fzf {
      command! FindInProject execute 'FZF' utils#FindProjectRoot()

      map <C-p> :FindInProject<CR>
      map <leader>l :BLines<CR>
      map <leader>b :Buffers<CR>
      map <leader>a :Ag<CR>
    " }

    " NERDTree {
      nmap <C-e> :NERDTreeToggle<CR>
      let g:NERDTreeCaseSensitiveSort=1
      let g:NERDTreeIgnore=['\~$', '\pyc', '__pycache__']
      let g:NERDTreeBookmarksFile='~/.vim/NERDTreeBookmarks'
      let g:NERDTreeMouseMode=2
    " }

    " Python-mode {
    " }

    " Tagbar {
      nmap <leader>tb :TagbarToggle<CR>

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

      let g:tagbar_type_rst = {
          \ 'ctagstype': 'rst',
          \ 'ctagsbin' : '/path/to/rst2ctags.py',
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

    " vim-cpp-enhanced-highlight {
      let g:cpp_class_scope_highlight = 1
      "let g:cpp_member_variable_highlight = 1
      "let g:cpp_class_decl_highlight = 1
      "let g:cpp_experimental_template_highlight = 1
    " }


    " YouCompleteMe Leftover {
      " Remap Ultisnips for compatibility with YCM
      let g:UltiSnipsExpandTrigger = '<C-j>'
      let g:UltiSnipsJumpForwardTrigger = '<C-j>'
      let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
    " }
  " }
" }


" Load any local configurations if available
if filereadable(expand(s:local_init_path))
    execute 'source ' . s:local_init_path
endif

" vim: set sw=2 ts=2 sts=2 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker :
