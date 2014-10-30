#!/bin/zsh

for f in text/*.txt; do
  output=cabocha_xml/$f:t:r".xml"
  echo "<root>" > $output
  sed -e 's/。/\n/g' $f | grep -v "^$" | cabocha -f3 >> $output
  echo "</root>" >> $output
done
