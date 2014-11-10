#!/bin/zsh


for d in ./result/*; do
  ./make_bigram.sh $d
  ./count_all_bigram.sh $d
done
