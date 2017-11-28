require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'

=begin

# BBC

url = "https://www.bbcgoodfood.com/recipes/mushroom-brunch"

page = Nokogiri::HTML(open(url))

title = page.title

mains = []

food = []


ingredientsLi = page.css("#recipe-ingredients > div > div > ul > li")

 ingredientsLi.each do |ing|

	combi =  ing.css("a").select{|link| link["href"].include?("/glossary/")}

	if !combi.empty?

	food << {"name"=> combi[2].text, "img"=> "http:#{combi[1].css("img").attr('src')}","name2"=> combi[0].text,}
	end

end

puts titlesArray = title.split('|')[0].split(' ').map{|item|item.downcase}  
puts "--"
puts ingredientsArray = food.map{|item|item["name"].downcase} 
puts ingredientsArray2 = food.map{|item|item["name2"].downcase} 

puts "+++"
puts mains = titlesArray & ingredientsArray
puts "==="
puts  mains2 = titlesArray & ingredientsArray2
puts ";;;;"
puts (mains+mains2).uniq


=end

# bigoven

food = []

url = "https://www.bigoven.com/recipe/chicken-pasta-with-basil-lemon-and-garlic/294885"

page = Nokogiri::HTML(open(url))

title = page.title

ingredientsArray = []

ingredientsLi = page.css("span[class = 'ingredient  '] span[class = 'name']")

 ingredientsLi.each do |ing|

	#combi =  ing.css("name")
	ingredientsArray << ing.text.downcase.split(' ')
	# food2<< combi.map{|item| {"name"=>item.text,"img"=>''}}

end

puts ingredientsArray = ingredientsArray.flatten

puts "------"

puts titlesArray = title.split(' ').map{|item|item.downcase} 

puts "====" 

puts ingredientsArray & titlesArray
