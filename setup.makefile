.DEFAULT_GOAL=all


#
# GTK Theme
#
.PHONY: download-gtk-theme
download-gtk-theme:
	mkdir -pv ~/.themes
	git clone -q https://github.com/petrucci4prez/BlackIce ~/.themes/BlackIce


#
# All
#
.PHONY: all
all: download-gtk-theme
