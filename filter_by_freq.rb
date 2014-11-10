# -*- coding: utf-8 -*-
#ruby filter_by_freq.rb $d/counted_filtered_verbs.txt $freq 

verb_file = ARGV[0]
freq = ARGV[1].to_i

#"動詞1 動詞2" タブ区切りされた行を標準入力から読み込み、
#動詞1も動詞2もfreq以上の頻度で使われている場合にフィルターを通過させる

#動詞の頻度を読み込む
verb_freq = {}
File.open(verb_file, 'r') do |f|
  while line=f.gets
    line.strip!
    cnt = line.split(" ")[0].to_i
    verb = line.split(" ")[1]

    verb_freq[verb] = cnt
  end
end

while line=STDIN.gets
 line.strip!
  verb1 = line.split("\t")[0]
  verb2 = line.split("\t")[1]

  n1 = 0
  if verb_freq.has_key?(verb1)
    n1 = verb_freq[verb1]
  end

  n2 = 0
  if verb_freq.has_key?(verb2)
    n2 = verb_freq[verb2]
  end


  if n1 >= freq && n2 >= freq
    puts line
  end
end
