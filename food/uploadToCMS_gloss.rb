require 'net/http'
require 'json'
require 'uri'
require_relative  'webflow'
require 'nokogiri'         
require 'open-uri'

allRecipes = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/allRecipes_withMust.json"))

allgloss = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/glossWithType.json"))


/creat gloss item first/

bodys = []

allgloss.each do |gloss|

	slug = gloss["name"].gsub('%20','')

	glossName = gloss["name"].split('%20').map{|word| word.capitalize}.join(' ')

	feature = false

	bodys <<{
		 "fields" => { 
	
		  			"name" => glossName,
		  			"feature"=> feature,
		  			"slug" => slug,

		  			"_archived" => false,
   			    	 "_draft" => false

					}
		}
end 

site =  Webflow.new()

ingredients = "5a214196897bf400019de830"

site.collection(ingredients)["fields"].map{|field| field["slug"]}

puts bodys.count

bodys[11..-1].each do |body|

	site.addItem(ingredients,body)

	sleep 1
puts bodys.index(body)
end