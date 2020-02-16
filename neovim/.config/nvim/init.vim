" Some constants pointing to local configuration files
let s:coc_config = expand('<sfile>:h') . '/coc.vim'
let s:local_init_path = expand('<sfile>:h') . '/local.init.vim'
let s:local_plugins_path = expand('<sfile>:h') . '/local.plugins.vim'
let s:plugin_path = expand('<sfile>:h') . '/plugged'


" Don't rely on the neovim python client to be installed in a virtualenv
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'


" Plugins {
call plug#begin(s:plugin_path)
  " General {
    Plug 'morhetz/gruvbox'                      " Color scheme
    Plug 'myusuf3/numbers.vim'                  " Toggle between relative and fixed line numbers
    Plug 'vim-airline/vim-airline'              " Status and tab bar

    " A file browser tree & a git plugin to go along
    Plug 'scrooloose/nerdtree',         { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

    " Fuzzy finder + vim integration
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    " Misc
    Plug 'junegunn/vim-easy-align'              " Text alignment
    Plug 'lambdalisue/suda.vim'                 " workaround for broken :w !sudo tee %
    Plug 'zhimsel/vim-stay'                     " Automatic view creation and restoration
  " }

  " General Programming {
    " Code {
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      Plug 'sheerun/vim-polyglot'               " Lots of syntax, indent & other things
      Plug 'majutsushi/tagbar'                  " Tags browser
    " }

    " VCS {
      Plug 'tpope/vim-fugitive'                 " Git integration
      Plug 'junegunn/gv.vim'                    " Git commit browser
    " }

    " Misc {
      Plug 'Raimondi/delimitMate'               " Auto close matching pairs of characters
      Plug 'mhinz/vim-signify'                  " Gutter diff indicator that integrates with VCSs
    " }
  " }

  " Python {
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Semantic highlight
  " }

  " ReStructuredText {
    Plug 'gu-fan/riv.vim',    {'for': 'rst'}    " ReStructuredText integration
  " }

  " If there's a local plugins file then source it
  if filereadable(s:local_plugins_path)
      execute 'source ' . s:local_plugins_path
  endif
call plug#end()
" }

" Settings {
  " General settings {
    set clipboard+=unnamedplus                    " Use the + register for copy-paste
    set hidden                                    " Allow buffer switching without saving
    set lazyredraw                                " Redraw only when needed
    set noswapfile                                " Disable swap files
    set shortmess+=filmnrxoOtT                    " Abbreviate some messages (avoids 'hit enter')
    set spell                                     " Turn on the spell checker
    set undofile                                  " Turn persistent undo on
    set undolevels=10000                          " Maximum number of changes to record
    set undoreload=10000                          " Maximum number lines to save for undo on a buffer reload
    set viewoptions=cursor,folds,slash,unix       " What info to store when saving view info
    set virtualedit=onemore                       " Allow the cursor to go beyond the last character
    set scrolloff=10                              " Minimal number of lines to keep above/bellow the cursor
    set scrolljump=1                              " Number of lines to scroll when the cursor gets off screen
  " }

  " Appearance {
    set termguicolors                             " Enable 24-bit RGB color support

    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark="hard"
    set background=dark
    colorscheme gruvbox

    set cursorline                                " Highlight current line
    set foldenable                                " Enable folding
    set hlsearch                                  " Highlight search terms
    set showmatch                                 " Show matching brackets

    " Highlight problematic white space
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
  " }

  " Functionality {
    set ignorecase                                " Case insensitive search
    set smartcase                                 " Unless upper case characters are present
    set inccommand=nosplit                        " Show incremental effects of substitution commands
    set mouse=a                                   " Allow mouse interaction
    set splitbelow                                " Puts new split windows to the bottom of the current
    set splitright                                " Puts new vsplit windows to the right of the current
    set whichwrap=b,s,h,l,<,>,[,]                 " Backspace and cursor keys wrap too
    set wildmenu                                  " List command completions instead of just completing
    set wildmode=list:longest,full                " Command <Tab> completion, list matches, then longest common part, then everything else
    set expandtab                                 " Insert spaces instead of tabs
    set nojoinspaces                              " Prevents inserting two spaces after punctuation on a join
    set nowrap                                    " Don't wrap long lines by default
    set shiftround                                " Round indent to multiple of 'shiftwidth'
    set shiftwidth=4                              " Use indents of 4 spaces
    set softtabstop=4                             " Let backspace delete indent
  " }

  " General keybinds {
    " Map leader key to space
    let mapleader="\<Space>"

    " Open man page 3 for word under cursor
    nnoremap <leader>m :Man 3 <C-r><C-w><CR>

    " Easier moving between splits
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    nnoremap <C-h> <C-w>h

    " Wrapped lines go down/up to next row rather than to the next line in file
    noremap j gj
    noremap k gk

    " Visual mode shifting does not exit visual mode
    vnoremap < <gv
    vnoremap > >gv

    " Use arrow keys to resize splits
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

    " For when I forget to edit with su permissions
    cmap w!! w suda://%
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
      nmap <leader>- <Plug>AirlineSelectNextTab
      nmap <leader>= <Plug>AirlineSelectPrevTab
    " }

    " Delimitmate {
      let delimitMate_expand_cr=1
    " }

    " fzf {
      command! FindInProject execute 'FZF' utils#FindProjectRoot()

      nnoremap <C-p> :FindInProject<CR>
      nnoremap <leader>l :BLines<CR>
      nnoremap <leader>b :Buffers<CR>
      nnoremap <leader>a :Ag<CR>
    " }

    " NERDTree {
      nmap <C-e> :NERDTreeToggle<CR>
      let g:NERDTreeCaseSensitiveSort=1
      let g:NERDTreeIgnore=['\~$', '\pyc', '__pycache__']
      let g:NERDTreeBookmarksFile=stdpath('data') . '/NERDTreeBookmarks'
      let g:NERDTreeMouseMode=2
    " }

    " semshi {
      let g:semshi#excluded_hl_groups = []                " Highlight local group as well
    " }

    " Tagbar {
      nmap <leader>tb :TagbarToggle<CR>

      let g:tagbar_type_markdown = {
          \ 'ctagstype': 'markdown',
          \ 'ctagsbin' : 'markdown2ctags',
          \ 'ctagsargs' : '-f - --sort=yes --sro=»',
          \ 'kinds' : [
              \ 's:sections',
              \ 'i:images'
          \ ],
          \ 'sro' : '»',
          \ 'kind2scope' : {
              \ 's' : 'section',
          \ },
          \ 'sort': 0,
      \ }

      let g:tagbar_type_rst = {
          \ 'ctagstype': 'rst',
          \ 'ctagsbin' : 'rst2ctags',
          \ 'ctagsargs' : '-f - --sort=yes --sro=»',
          \ 'kinds' : [
              \ 's:sections',
              \ 'i:images'
          \ ],
          \ 'sro' : '»',
          \ 'kind2scope' : {
              \ 's' : 'section',
          \ },
          \ 'sort': 0,
      \ }
    " }

    " vim-polyglot: vim-cpp-enhanced-highlight {
      let g:cpp_class_scope_highlight = 1
    " }
  " }
" }

" Load coc.nvim configuration
if filereadable(s:coc_config)
    execute 'source ' . s:coc_config
endif

" Load any local configurations if available
if filereadable(s:local_init_path)
    execute 'source ' . s:local_init_path
endif

" vim: set sw=2 ts=2 sts=2 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker :
