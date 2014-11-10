#!/bin/zsh
d=$1
if test -z $d; then
  d="."
fi

#頻度がこれ以上の動詞の限定してPMIを調べる
freq=10

cat $d/verb_chain/*.txt | LC_ALL=C sort | uniq -c | awk -v freq=$freq '$1 >= freq {print $0}' | LC_ALL=C sort -nr > $d/counted_filtered_verbs.txt

cat $d/verb_bigram/*.txt | ruby filter_by_freq.rb $d/counted_filtered_verbs.txt $freq | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_filtered_bigrams.txt

verb_sum=`cat $d/verb_chain/*.txt | wc -l`
awk -v sum=$verb_sum '{print $1/sum"\t"$2}' $d/counted_filtered_verbs.txt > $d/filtered_verbs_probability.txt
  
bigram_sum=`cat $d/verb_bigram/*.txt | wc -l`
awk -v sum=$bigram_sum '{print $1/sum"\t"$2"\t"$3}' $d/counted_filtered_bigrams.txt > $d/filtered_bigrams_probability.txt

ruby calc_pmi.rb $d/filtered_verbs_probability.txt $d/filtered_bigrams_probability.txt | sort -nr > $d/filtered_pmi.txt
