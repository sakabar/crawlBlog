#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=`pwd`
fi


#<br>などを改行に置換したファイルをmid_data内に置く
for f in $dir/entries/*.html; do
  sed -e 's|<br />|\n|g' -e 's|<br>|\n|g' $f > $dir/mid_data/$f:t
done

for f in $dir/mid_data/*.html; do
  ruby extract_text.rb $f | nkf -Lu | tr -d '\t' | sed -e 's/ *//g' | grep -v "^$" > $dir/text/$f:t:r".txt"
  #rm -f $f
done
