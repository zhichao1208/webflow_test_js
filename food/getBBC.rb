require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'

=begin
recipeLinks = []

for n in (0..50)

list = "https://www.bbcgoodfood.com/search/recipes/course/dinner/course/lunch/time/%255B0%2520TO%25201800%255D#page=#{n}&path=course/36/course/lunch/course/40/course/side-dish/course/46/time/%5B0+TO+1800%5D"

page = Nokogiri::HTML(open(list))

puts title = page.title

recipeLinks << page.css("h3[class = 'teaser-item__title']").map{|item| item.css("a")[0]["href"]}

puts n

n+=1

sleep 1

end

recipeLinks = recipeLinks.flatten

File.open("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_bbc.json","w") do |f|
  f.write(recipeLinks.to_json)
end
=end
data = JSON.parse(File.read('/Users/li/Downloads/Script/gitFiles/food/recipeLinks_bbc.json'))

data.each do |item|

	url = "https://www.bbcgoodfood.com#{item}"

	page = Nokogiri::HTML(open(url))

	puts title = page.title


break
end	
