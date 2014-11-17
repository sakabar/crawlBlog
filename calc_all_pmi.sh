#!/bin/zsh
d=$1
if test -z $d; then
  d="."
fi


cat $d/verb_chain/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_all_verbs.txt


#verb_bigramがないといけない
#あらかじめ、./make_bigram.shをしておくこと
cat $d/verb_bigram/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_all_bigrams.txt

verb_sum=`cat $d/verb_chain/*.txt | wc -l`
awk -v sum=$verb_sum '{print $1/sum"\t"$2}' $d/counted_all_verbs.txt > $d/all_verbs_probability.txt
  
bigram_sum=`cat $d/verb_bigram/*.txt | wc -l`
awk -v sum=$bigram_sum '{print $1/sum"\t"$2"\t"$3}' $d/counted_all_bigrams.txt > $d/all_bigrams_probability.txt

ruby calc_pmi.rb $d/all_verbs_probability.txt $d/all_bigrams_probability.txt | sort -nr > $d/all_pmi.txt
