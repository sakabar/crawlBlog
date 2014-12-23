#!/bin/zsh
d=$1
if test -z $d; then
  d="."
fi


cat $d/arg_str_chain/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_all_argstrs.txt


#arg_str_bigramがないといけない
#あらかじめ、./make_argstr_bigram.shをしておくこと
cat $d/arg_str_bigram/*.txt | LC_ALL=C sort | uniq -c | LC_ALL=C sort -nr > $d/counted_all_argstr_bigrams.txt

argstr_sum=`cat $d/arg_str_chain/*.txt | wc -l`
awk -v sum=$argstr_sum '{print $1/sum"\t"$2}' $d/counted_all_argstrs.txt > $d/all_argstrs_probability.txt
  
bigram_sum=`cat $d/arg_str_bigram/*.txt | wc -l`
awk -v sum=$bigram_sum '{print $1/sum"\t"$2"\t"$3}' $d/counted_all_argstr_bigrams.txt > $d/all_argstr_bigrams_probability.txt

ruby calc_pmi.rb $d/all_argstrs_probability.txt $d/all_argstr_bigrams_probability.txt | sort -nr > $d/all_argstr_pmi.txt
