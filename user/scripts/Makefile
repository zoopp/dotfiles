.DEFAULT_GOAL=all

# ----------------------------------------------------------------------------------------------------
# ViM
.PHONY: vim-base
vim-base:
	mkdir -pv ~/.vim/view
	mkdir -pv ~/.vim/undodir
	git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

.PHONY: vim-vimproc
vim-vimproc: vim-base
	cd ~/.vim/bundle/vimproc.vim; \
	make

.PHONY: vim-ycm
vim-ycm: vim-base
	cd ~/.vim/bundle/YouCompleteMe; \
	./install.sh --clang-completer

.PHONY: setup-vim
setup-vim: vim-base vim-vimproc vim-ycm

# ----------------------------------------------------------------------------------------------------
.PHONY: download-gtk-theme
download-gtk-theme:
	mkdir -pv ~/.themes
	git clone -q https://github.com/petrucci4prez/BlackIce ~/.themes/BlackIce

# ----------------------------------------------------------------------------------------------------
.PHONY: all
all: setup-vim download-gtk-theme
