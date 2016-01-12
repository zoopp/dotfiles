.DEFAULT_GOAL=all


# ----------------------------------------------------------------------------------------------------
# ViM
.PHONY: setup-vim
setup-vim:
	mkdir -pv ~/.vim/view
	mkdir -pv ~/.vim/undodir
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall


# ----------------------------------------------------------------------------------------------------
# GTK Theme
.PHONY: download-gtk-theme
download-gtk-theme:
	mkdir -pv ~/.themes
	git clone -q https://github.com/petrucci4prez/BlackIce ~/.themes/BlackIce


# ----------------------------------------------------------------------------------------------------
#  All
.PHONY: all
all: setup-vim download-gtk-theme
