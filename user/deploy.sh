#!/bin/bash

conf_dir="files"
backup_dir="backup/"`date +%F%T`

for file_path in `find "$conf_dir" -type f`; do
    full_path=`realpath "$file_path"`
    relative_path=`realpath "$file_path" --relative-to="$PWD/$conf_dir"`
    home_path="$HOME/$relative_path"

    if [ -f "$home_path" ]; then
        backup_path="$backup_dir/$home_path"
        mkdir -pv `dirname "$backup_path"`
        mv -iv "$home_path" "$backup_path"
    fi

    mkdir -pv `dirname $home_path`
    ln -sv "$full_path" "$home_path"
done


make -C scripts -j 10 -k -B
