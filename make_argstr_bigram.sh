#!/bin/zsh

d=$1
if test -z $d; then
  d="."
fi

mkdir $d/arg_str_chain
for f in $d/arg_str/*.txt; do
  awk '$2 == "が" {print $3}' $f > $d/arg_str_chain/$f:t
done 

mkdir $d/arg_str_bigram
for f in $d/arg_str_chain/*.txt; do
  ./paste_bigram.sh $f > $d/arg_str_bigram/$f:t
done 
