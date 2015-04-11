#!/bin/bash
EXCLUDE=(
--exclude="*.md" 
--exclude="*.scss" 
--exclude="sass" 
--exclude=".sass-cache"
)
sass ../../src/content/style/sass/index.scss:../../src/content/style/index.css
find ../../build/raw/ -mindepth 1 -maxdepth 1 -not -name '.gitignore' | tail -n +1 | xargs -n1 rm -rf
find ../../build/styled/ -mindepth 1 -maxdepth 1 -not -name '.gitignore' | tail -n +1 | xargs -n1 rm -rf
rsync --verbose --recursive "${EXCLUDE[@]}" ../../src/content/ ../../build/raw/
rsync --verbose --recursive "${EXCLUDE[@]}" ../../src/content/ ../../build/styled/
./writeraw.py
./writestyled.py