require 'nokogiri'


# html_file = "entries/1130-1127_entry-11938978679.html"
html_file = ARGV[0]

f = File.open(html_file)

doc = Nokogiri::HTML(f)
bd = doc.xpath("//div[@class = 'articleText']")
puts bd.inner_text

f.close
