#!/bin/zsh

#<br>などを改行に置換したファイルをmid_data内に置く
for f in entries/*.html; do
  sed -e 's|<br />|\n|g' -e 's|<br>|\n|g' $f > mid_data/$f:t
done

for f in mid_data/*.html; do
  ruby extract_text.rb $f | nkf -Lu | tr -d '\t' | sed -e 's/ *//g' | grep -v "^$" > text/$f:t:r".txt"
  #rm -f $f
done
