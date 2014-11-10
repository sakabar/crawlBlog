# -*- coding: utf-8 -*-
# $d/all_verbs_probability.txt
# $d/all_bigrams_probability.txt
# があるときに、PMIを計算する

verb_p_file = ARGV[0]
bigram_p_file = ARGV[1]

#verbとpの関係をハッシュに格納
verb_p = {}
File.open(verb_p_file, 'r') do |f|
  while line = f.gets
    line.rstrip!

    p = line.split("\t")[0].to_f
    verb = line.split("\t")[1]
    verb_p[verb] = p
  end
end

#PMIを計算
File.open(bigram_p_file, 'r') do |f|
  while line = f.gets
    line.rstrip!
    pxy = line.split("\t")[0].to_f
    x = line.split("\t")[1]
    y = line.split("\t")[2]

    pmi = Math.log10(pxy) - Math.log10(verb_p[x]) - Math.log10(verb_p[y])
    puts "#{pmi}\t#{x}\t#{y}"
  end
end


