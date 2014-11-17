#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi

mkdir $dir/bigram_count
for f in $dir/verb_bigram/*.txt; do
  LC_ALL=C sort $f | uniq -c | LC_ALL=C sort -k 2,2 > $dir/bigram_count/$f:t
done
