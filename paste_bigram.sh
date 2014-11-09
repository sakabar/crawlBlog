#!/bin/zsh

file_name=$1

line=`cat $file_name | wc -l`

paste <(head -n $[$line - 1] $file_name) <(tail -n +2 $file_name)


