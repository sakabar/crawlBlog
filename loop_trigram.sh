#!/bin/zsh


for d in ./result/*; do
  ./make_trigram.sh $d
  ./count_all_trigrams.sh $d
done
