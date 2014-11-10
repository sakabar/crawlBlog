#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=`pwd`
fi

mkdir $dir/bigram_probability
for f in $dir/bigram_count/*.txt; do
  sum=`cat $dir/verb_bigram/$f:t | wc -l`
  awk -v sum=$sum '{print $1/sum"\t"$2"\t"$3}' $f > $dir/bigram_probability/$f:t
done
