#!/bin/zsh

f=`cat - | sed -e 's|_entry|/entry|'`
echo "http://ameblo.jp/"$f:r".html"
