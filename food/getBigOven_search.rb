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
=end

list = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/glossList.json"))

list = list.map{|item| item["name"]}.flatten!.sort.slice_when{|i,j| j!=i}.map{|item| {"name"=>item[0],"count"=>item.count}}.sort_by{|item| item["count"]}.reverse

sides = ["parmesan","parsley","lemon","garlic","onion"]


mains = ["chicken breast","tomatoes","chicken","egg","tortilla","chicken broth","ground beef",
		"mushrooms","tomato","milk","pasta","mozzarella","paprika","rice","cheddar cheese"]


data = []

for i in (1..4)
data = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_#{i}.json"))
end

data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks.json"))
data << JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/recipeLinks_search.json"))

data.flatten!.uniq!

puts list[0]


data[0..1].each do |item|	

	page = Nokogiri::HTML(open(item))

	 title = page.title

	 # puts glossList2 = page.css("span[class = 'name']")

	glossLists = page.css("a[class = 'glosslink']").map{|item| item.text.downcase}

	glossListsWithVote = []

	glossLists.each do |gloss|

		thing = list.find{|item| item["name"] == gloss}


		if !thing.nil?

			glossListsWithVote << [gloss,thing["count"]]

		else

			glossListsWithVote << [gloss,0]

		end


end

	mains5 = glossListsWithVote.sort_by{|item| item[1]}.reverse[0..5]

	mains3 = glossListsWithVote.sort_by{|item| item[1]}.reverse[0..3]

	others = glossListsWithVote.sort_by{|item| item[1]}.reverse

	puts "mains5 is #{mains5.to_s}"
	puts "mains3 is #{mains3.to_s}"
	puts "others is #{others.to_s}"
	puts "--------"

	sleep 1



end
