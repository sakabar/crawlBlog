#!/bin/zsh


for d in ./result/*; do
  ./make_trigram.sh $d
  ./count_trigram.sh $d
done
