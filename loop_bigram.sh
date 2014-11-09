#!/bin/zsh


for d in ./result/*; do
  mkdir $d/verb_ngram

  for f in $d/verb_chain/*.txt; do
    ./paste_bigram.sh $f > $d/verb_ngram/$f:t
  done 
done
