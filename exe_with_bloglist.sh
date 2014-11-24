#!/bin/zsh

#exe_with_bloglist.shはブログのURLを格納したファイル引数にとって実行する
#./exe.sh bloglist.txt
#この場合、bloglist.txtに含まれるURLからブログをダウンロードする



if [ $# -eq 1 ]; then
    bloglist=$1
else
    echo "ERROR: 引数を1つ指定してください" 1>&2
    exit
fi

#bloglist.txtを退避
tmpfile=`mktemp`
mv $bloglist $tmpfile

#消去
./clean.sh

mv $tmpfile $bloglist

mkdir entries/ text/ verb_chain/ mid_data/ cabocha_xml/


#ブログ一覧をもとに、ブログをダウンロード
./getBlog.sh $bloglist

#各エントリから本文のみを抽出
./extractText.sh

#cabochaを使ってパーズ
./parseWithCabocha.sh

#パーズの結果から、本文に含まれる動詞を抜き出す
./getVerbChunk.sh

#bigramを作る
./make_bigram.sh

dir=`date "+%Y_%m%d_%H%M"`
mkdir $dir
mv entries/ text/ verb_chain/ mid_data/ cabocha_xml/ verb_bigram/ $bloglist $dir
mv $dir result
