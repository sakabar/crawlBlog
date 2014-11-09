#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=`pwd`
fi

for f in $dir/cabocha_xml/*; do
  ruby getVerbChunk.rb $f | awk -F, '{print $7}' > $dir/verb_chain/$f:t:r".txt"
done
