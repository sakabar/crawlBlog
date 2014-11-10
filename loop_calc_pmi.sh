#!/bin/zsh


for dir in ./result/*; do
  #bigramは$dir/verb_bigramに格納されている、という前提
  ./count_bigrams.sh $dir
  ./count_verbs.sh $dir
  ./calc_bigram_probability.sh $dir
  ./calc_verb_probability.sh $dir
  ./calc_pmi.sh $dir
done
