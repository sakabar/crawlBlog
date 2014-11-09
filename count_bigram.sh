#!/bin/zsh

for d in ./result/*; do
  cat $d/verb_ngram/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted.txt
done
