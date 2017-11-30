require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'

=begin
recipeLinks = []

for n in (1..50)

list = "https://www.bigoven.com/recipes/search/page/#{n}?include_primarycat=main+dish&medianmin=30&favoriteofme=False&view=default&photos=1&db=722%2c722"

page = Nokogiri::HTML(open(list))

puts title = page.title


recipeLinks << page.css("li[class = 'list-group-recipetile-1']").map{|item| item.css("a")[0]["href"]}

puts n

n+=1

sleep 1

end

recipeLinks = recipeLinks.flatten

File.open("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_search.json","w") do |f|
  f.write(recipeLinks.to_json)
end

data = []

for i in (1..4)
data = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_#{i}.json"))
end

data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks.json"))
data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_search.json"))

data.flatten!.uniq!

puts data.count

glossList = []

data.each do |item|

	puts item
	puts data.index(item)

	page = Nokogiri::HTML(open(item))

	puts title = page.title

	 # puts glossList2 = page.css("span[class = 'name']")

	glossList << page.css("a[class = 'glosslink']").map{|item| item.text.downcase}

	sleep 1

end	

glossList = glossList.sort.slice_when{|i,j| j!=i}.map{|item| {"name"=>item[0],"count"=>item.count}}.sort_by{|item| item["count"]}.reverse

File.open("/Users/li/Downloads/Script/gitFiles/food/glossList.json","w") do |f|
  f.write(glossList.to_json)
end

list = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/glossList.json"))

list = list.map{|item| item["name"]}.flatten!.sort.slice_when{|i,j| j!=i}.map{|item| {"name"=>item[0],"count"=>item.count}}.sort_by{|item| item["count"]}.reverse

data = []

for i in (1..4)
data = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_#{i}.json"))
end

data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks.json"))
data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_search.json"))

data.flatten!.uniq!

File.open("/Users/li/Downloads/Script/gitFiles/food/data.json","w") do |f|
  f.write(data.to_json)
end
=end

data = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/data.json"))


recipesArray = []

n = 1200
i = -1


data[n..i].each do |item|	

	page = Nokogiri::HTML(open(item))

	title = page.title

	 recipeName = page.css("h1")[0].text.gsub(/<\/?[^>]*>/, "")

	 time = page.css("div[class ='ready-in rc-opt']")[0].text.lstrip!.gsub(/<\/?[^>]*>/, "")

	 rate = page.css("div[class = 'recipe-rating rc-opt']").css("i[class ='ss ss-star gold']").count

if !page.css("div[class ='trying light-med-grey hidden-xs']")[0].nil?
	 vote = page.css("div[class ='trying light-med-grey hidden-xs']")[0].text.lstrip!.gsub(/<\/?[^>]*>/, "")
	else
vote = ""
end

	 img = page.css("img[class ='recipe-hero-photo img-responsive']")[0]["src"]

	ingredientsContent = page.css("ul[class ='ingredients-list']").css("li")


	 ingredientsList = page.css("ul[class ='ingredients-list']").css("span[class ='name']").map{|li| li.text.downcase}


	 instructions = page.css("div[class ='recipe-instructions']")[0].text.strip!.gsub(/<\/?[^>]*>/, "")

	sleep 1

	puts data.index(item)

	recipesArray <<{"name"=>recipeName,"time"=>time,"rate"=>rate,"vote"=>vote,"img"=>img,"ingredientsList"=>ingredientsList,"ingredientsContent"=>ingredientsContent,"instructions"=>instructions}

end

File.open("/Users/li/Downloads/Script/gitFiles/food/recipes#{n}-#{i}.json","w") do |f|
  f.write(recipesArray.to_json)
end
