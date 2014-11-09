#!/bin/zsh

d=$1

mkdir $d/verb_trigram

for f in $d/verb_chain/*.txt; do
  ./paste_trigram.sh $f > $d/verb_trigram/$f:t
done 
