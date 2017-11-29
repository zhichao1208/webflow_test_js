require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'
=begin
recipeLinks = []

for n in (1..7)

type = "30-one-pot-meals/296/page/#{n}"

list = "https://www.bigoven.com/recipe-ideas/#{type}"

page = Nokogiri::HTML(open(list))

puts title = page.title


recipeLinks << page.css("li[class = 'list-group-recipetile-1']").map{|item| item.css("a")[0]["href"]}

puts n

n+=1

sleep 1

end

recipeLinks = recipeLinks.flatten

File.open("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_4.json","w") do |f|
  f.write(recipeLinks.to_json)
end
=end

data = []
for n in (1..4)

data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_#{n}.json"))

end

data<< JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks.json"))

 data.flatten!


data.each do |item|

	puts item

	page = Nokogiri::HTML(open(item))

	 puts title = page.title

	 # puts glossList2 = page.css("span[class = 'name']")

	 puts glossList = page.css("a[class = 'glosslink']")

	 break

end	







