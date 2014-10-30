#coding: utf-8
require 'nokogiri'


html_file = ARGV[0]
# html_file = "/home/lr/tsakaki/crawlBlog/cabocha_xml/bunsenkuru_entry-11939493054.xml"

f = File.open(html_file)
doc = Nokogiri::XML(f)
f.close

chunks = doc.xpath("//chunk")

chunks.each do |chunk|
  head_id = chunk.attributes["head"].to_str.to_i
  head_tok = chunk.xpath("./tok[@id = #{head_id}]")[0]

  #チャンクのheadが動詞以外(名詞など)ならば無視
  if (head_tok["feature"].split(',')[0] == "動詞")
    #もし、headが「する」であり、かつ直前のトークンが「サ変接続の名詞」ならば、head_tokを直前のトークンにする
    prev_tok = chunk.xpath("./tok[@id = #{head_id - 1}]")[0]
    if ((! prev_tok.nil?))
      if  (head_tok["feature"].split(',')[4] == "サ変・スル") && (prev_tok["feature"].split(',')[0] == "名詞")
        head_tok = prev_tok
      end
    end

    #head_tokが一般名詞のときは出力形式を変える
    if head_tok["feature"] == "名詞,一般,*,*,*,*,*"
      puts "名詞,一般,*,*,*,*,#{head_tok.text}"
    else
      puts head_tok["feature"]
    end

  end

end
