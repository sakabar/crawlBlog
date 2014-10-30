#!/bin/zsh

xml_file=$1
# xml_file="tmp.cabocha.xml"

for f in cabocha_xml/*; do
  ruby getVerbChunk.rb $f | awk -F, '{print $7}' > verb_chain/$f:t:r".txt"
done
