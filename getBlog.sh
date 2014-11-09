#!/bin/zsh

bloglist=$1

function change_proxy(){
  export http_proxy=http://`cat proxy_list.txt | grep -v "^#" | sort -R | head -n1`/
}

function my_wget(){
  change_proxy
  wget $1 -T5 --tries=1 --inet4-only --no-verbose -O $2
}


#sort -Rが使える環境である必要がある
for url in `cat $bloglist`; do
  output=`echo $url | sed -e 's|^http://ameblo.jp/||' | tr '/' '_'`
  my_wget $url entries/$output
  wget_status=$? # $? は直前のコマンドの終了ステータス(0が正常)

  #wgetが失敗したら、proxyを切り換えて再試行
  if test $wget_status -ne 0; then
    if test `wget $url --spider 2>&1 | grep "404 Not Found" | wc -l` -gt 0; then
      #そもそもページが存在しないので、プロキシの問題ではない
      rm entries/$output
    fi
  else
    bad_proxy=`echo $http_proxy | sed -e 's|^http://||' -e 's|/$||'`
    tmp_file=`mktemp`
    grep -v $bad_proxy proxy_list.txt > $tmp_file
    mv $tmp_file proxy_list.txt

    my_wget $url entries/$output
  fi
done

echo "ブログ記事のダウンロードが終了しました。"


