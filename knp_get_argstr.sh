#!/bin/zsh

dir=$1
if test -z $dir; then
  dir=.
fi

user_name=tsakaki
dir_name=$dir:t
code_dir=$HOME/local/src/matsunag_code

mkdir /local/$user_name/$dir_name
mkdir /local/$user_name/$dir_name/formated_text
mkdir /local/$user_name/$dir_name/knp
mkdir /local/$user_name/$dir_name/arg_str

for f in $dir/text/*.txt; do
  $code_dir/my_format_string.sh < $f \
  | tee /local/$user_name/$dir_name/formated_text/$f:t \
  | juman \
  | knp -tab -dpnd-fast | tee /local/$user_name/$dir_name/knp/$f:t:r".knp" \
  | python $code_dir/knp_get_argstr.py dpnd genbun jidou > /local/$user_name/$dir_name/arg_str/$f:t
done

