#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi


#<br>などを改行に置換したファイルをmid_data内に置く
#google_ad_section_start(name=s1 からgoogle_ad_section_end(name=s1 までを抜き出しておく。これが本文
for f in $dir/entries/*.html; do
  output=$dir/mid_data/$f:t
  awk '/google_ad_section_start\(name=s1/, /google_ad_section_end\(name=s1/ {print $0}' $f | sed -e 's|<br />|\n|g' | sed -e 's|<br>|\n|g' | sed -e 's/\&nbsp;/ /g' >> $output
done

for f in $dir/mid_data/*.html; do
  # ruby extract_text.rb $f | nkf -Lu | tr -d '\t' | sed -e 's/ *//g' | grep -v "^$" > $dir/text/$f:t:r".txt"
  sed -e 's|<[^>]\+>||g' $f | sed -e 's|</[^>]\+>||g' | nkf -Lu | tr -d '\t' | sed -e 's/ *//g' | grep -v "^$" > $dir/text/$f:t:r".txt"
done
