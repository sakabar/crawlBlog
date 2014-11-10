#!/bin/zsh

d=$1

cat $d/verb_bigram/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_bigram.txt
