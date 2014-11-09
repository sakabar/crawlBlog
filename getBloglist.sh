#!/bin/zsh

if test $# -eq 0; then
  echo "引数の数が足りません。クエリのキーワードを1個以上引数として指定してください。"
  echo 'USAGE: ./getBloglist "ご飯" "食べた"'
  exit 1
fi

str='%2B"'$1"\""

if test $# -ge 2; then
  for i in {2..$#}; do
    str=$str'+%2B"'$@[$i]"\""
  done
fi

#1ページに何件のブログを表示させるか
row=100

# query="http://search.ameba.jp/search.html?q="$str"&row="$row"&profileRow=&target=blog&aid=&author=all&start=0"
# echo $query > query.txt

#検索するページ数
page=10
cat /dev/null > query.txt
for i in {00..$[$page-1]}; do
  start=$[0 + $row * $i]
  query="http://search.ameba.jp/search.html?q="$str"&row="$row"&profileRow=&target=blog&aid=&author=all&start="$start
  echo $query >> query.txt
  wget $query -T5 --tries=1 --no-proxy -O search_result_$i".html"
done

cat search_result_*.html | grep -o "http://ameblo.jp/.*/entry-.*.html" | sort > bloglist.txt

