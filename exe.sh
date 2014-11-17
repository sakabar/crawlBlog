#!/bin/zsh

#消去
./clean.sh

mkdir entries/ text/ verb_chain/ mid_data/ cabocha_xml/

#クエリを投げて関連するブログの一覧を取得
./getBloglist.sh $@

if test $? -eq 1; then
  exit
fi

#ブログ一覧をもとに、ブログをダウンロード
./getBlog.sh ./bloglist.txt

#各エントリから本文のみを抽出
./extractText.sh

#cabochaを使ってパーズ
./parseWithCabocha.sh

#パーズの結果から、本文に含まれる動詞を抜き出す
./getVerbChunk.sh

#bigramを作る
./make_bigram.sh

dir=`date "+%Y%m%d%H%M"`
mkdir $dir
mv entries/ text/ verb_chain/ mid_data/ cabocha_xml/ verb_bigram/ query.txt search_result_*.html bloglist.txt $dir
mv $dir result
