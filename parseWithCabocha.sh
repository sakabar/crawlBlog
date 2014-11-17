#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi

for f in $dir/text/*.txt; do
  output=$dir/cabocha_xml/$f:t:r".xml"
  echo "<root>" > $output
  sed -e 's/。/\n/g' $f | grep -v "^$" | cabocha -f3 >> $output
  echo "</root>" >> $output
done
