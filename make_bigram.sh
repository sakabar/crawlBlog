#!/bin/zsh

d=$1
if test -z $d; then
  d="."
fi

mkdir $d/verb_bigram
for f in $d/verb_chain/*.txt; do
  ./paste_bigram.sh $f > $d/verb_bigram/$f:t
done 
