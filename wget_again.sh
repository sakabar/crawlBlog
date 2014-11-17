#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi

./clean.sh

#行数が最少のエントリを取得する
min_line=`wc -l $dir/entries/*.html | grep -v "^ \+0 " | sort -n | head -n1 | awk '{print $1}'`
wc -l $dir/entries/*.html | grep " $min_line " |  awk '{print $2}' | xargs -P1 -L1 -I% basename % | ./ameblo_url.sh > bloglist.txt

mkdir entries/ text/ verb_chain/ mid_data/ cabocha_xml/

#ブログ一覧をもとに、ブログをダウンロード
./getBlog.sh bloglist.txt

#各エントリから本文のみを抽出
./extractText.sh

#cabochaを使ってパーズ
./parseWithCabocha.sh

#パーズの結果から、本文に含まれる動詞を抜き出す
./getVerbChunk.sh

mv entries/* $dir/entries/
mv text/* $dir/text/
mv verb_chain/* $dir/verb_chain/
mv mid_data/* $dir/mid_data/
mv cabocha_xml/* $dir/cabocha_xml/

