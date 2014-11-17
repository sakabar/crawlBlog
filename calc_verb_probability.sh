#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi

mkdir $dir/verb_probability
for f in $dir/verb_count/*.txt; do
  sum=`cat $dir/verb_chain/$f:t | wc -l`
  awk -v sum=$sum '{print $1/sum"\t"$2}' $f > $dir/verb_probability/$f:t
done
