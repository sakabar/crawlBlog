#!/bin/zsh

for d in ./result/*; do
  cat $d/verb_trigram/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_trigram.txt
done
