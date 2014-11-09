#!/bin/zsh

dir=$1
if test -n $dir; then
  dir=`pwd`
fi

echo $dir
exit

for f in $dir/cabocha_xml/*; do
  ruby getVerbChunk.rb $f | awk -F, '{print $7}' > $dir/verb_chain/$f:t:r".txt"
done
