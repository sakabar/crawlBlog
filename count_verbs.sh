#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi

mkdir $dir/verb_count
for f in $dir/verb_chain/*.txt; do
  LC_ALL=C sort $f | uniq -c | LC_ALL=C sort -k 2,2 > $dir/verb_count/$f:t
done
