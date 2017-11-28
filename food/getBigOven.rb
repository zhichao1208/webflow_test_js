require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'


for page in (1..7)

type = "quick-and-easy-weeknight-dinners/49/page/#{page}"

list = "https://www.bigoven.com/recipe-ideas/#{type}"

page = Nokogiri::HTML(open(list))

# title = page.title

recipeLinks = []

recipeLinks << page.css("li[class = 'list-group-recipetile-1']").map{|item| item.css("a")[0]["href"]}

sleep 1
end

recipeLinks = recipeLinks.flatten

File.open("/Users/li/Downloads/Script/food/recipeLinks.json","w") do |f|
  f.write(recipeLinks.to_json)
end


