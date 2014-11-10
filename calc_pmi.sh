#!/bin/zsh
#数学関数をインポートする
zmodload zsh/mathfunc


dir=$1
if test -z $dir; then
  dir=`pwd`
fi

mkdir $dir/bigram_pmi
for f in $dir/bigram_probability/*.txt; do
  for line in `cat $f | tr '\t' ',' `; do
    pxy=`echo $line | awk -F, '{print $1}'`
    x=`echo $line | awk -F, '{print $2}'`
    y=`echo $line | awk -F, '{print $3}'`
    
    #タブはgrepで検索しにくいので,に置換する
    #\\を入れているのは、verbの'*'をメタ文字として解釈させないようにするため

    p1=",\\"$x"$"
    px=`cat $dir/verb_probability/$f:t | tr '\t' ',' | grep $p1 | awk -F, '{print $1}'`

    p2=",\\"$y"$"
    py=`cat $dir/verb_probability/$f:t | tr '\t' ',' | grep $p2 | awk -F, '{print $1}'`

    # echo "line = $line" 1>&2
    # echo "px = $px" 1>&2
    # echo "py = $py" 1>&2
    # echo ""

    echo $[log10($pxy) - log10($px) - log10($py)]"\t"$x"\t"$y
  done > $dir/bigram_pmi/$f:t
done
