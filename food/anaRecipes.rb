require 'net/http'
require 'uri'
require 'nokogiri'         
require 'open-uri'

require 'active_support/inflector'

require_relative 'getCategory'

# ingredients =  getRecipes.map{|recipe| recipe["ingredientsList"].map{|item| item.singularize} }.flatten

# singlar 

# glossData = ingredients.sort.slice_when{|i,j| j!=i}.map{|item|{"name"=>item[0],"count"=>item.count} }.sort_by{|item| item["count"]} 

=begin
useless = ["boneless","skinless","fresh","finely",
	"chopped","sliced","ground","freshly","and","thinly","sliced",
	"toasted","uncooked","whole","wheat","wild","powdered","prepared",
	"refrigerated","roasted","seasoned","shaved","cocked","shredded","sliced","water","slices",
	"thinly","sliced","optional","minced","tbls","diced","(melted)","(softened)","extra","virgin",
	"skinless,","skinless","small-diced","grated","extra-virgin","peeled","diced","tsp.","reduced-sodium",
	"reduced-fat"]
=end

# recipes each 

	# singlar 
	# delete useless word

allgloss = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/glossWithType.json"))


allgloss[-3..-2].each do |gloss|

	if !gloss["category"].empty? 

	gloss["category"] =  gloss["category"].slice_when{|i,j| j["level"] == "1" }.to_a[0]

		if gloss["category"].count>3

			gloss["category"] = gloss["category"][0..2]
		end	
	end
	#puts gloss["category"].slice_when{|i,j| j["level"] == 1 }.to_a

end


allRecipes = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/allRecipes.json"))

allRecipes[9..10].each do |recipe|

	itemArray = []

	 recipe["ingredientsList_new"].uniq.each do |item|

	 	hasType = allgloss.find{|gloss| gloss["name"] == item}

	 	if !hasType.nil?

	 		itemArray  << {"name" => item,"type"=>hasType["category"]}

	 	else

	 		itemArray  << {"name" => item,"type"=>[]}


	 	end	

	end

recipe["ingredientsList_new"] = itemArray
puts recipe["name"]
puts recipe["ingredientsList_new"].select{|item| item["type"][0]["name"] == "Fresh"}.map{|item| "#{item["name"]} - - #{item["type"][1]["name"]}" }

#.select{|item| item["type"][0]["name"] == "Fresh"}
	break

end

## find main


