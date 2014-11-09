#!/bin/zsh

for line in `cat -`; do
  f=`echo $line:r:t | sed -e 's|_entry|/entry|'`
  echo "http://ameblo.jp/"$f".html"
done
