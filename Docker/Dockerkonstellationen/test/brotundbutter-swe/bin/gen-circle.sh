#!/usr/bin/env bash
function doconvert(){
  if [[ $(uname -sr) =~ MINGW.* ]]; then
    magick convert "$@"
  else 
    convert "$@"
  fi
}

doconvert -define png:exclude-chunks=date +set date:create +set date:modify -strip \
       	-size 600x400 canvas:skyblue \
	-fill blue \
	-stroke black -strokewidth 10\
	-draw "circle 300,200 300,390" \
	-fill black \
	-stroke black -strokewidth 1\
	-font "Liberation-Sans" \
	-pointsize 60 \
	-gravity center \
	-draw "text 0,0 MoinMoin" \
	misc/small.png
