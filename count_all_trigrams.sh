#!/bin/zsh

d=$1
cat $d/verb_trigram/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_trigram.txt
