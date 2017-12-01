require 'net/http'
require 'uri'
require 'nokogiri'         
require 'open-uri'
require 'similar_text'
require 'active_support/inflector'

require_relative 'getCategory'


def string_difference_percent(a, b)
  longer = [a.size, b.size].max
  same = a.each_char.zip(b.each_char).select { |a,b| a == b }.size
  (longer - same) / a.size.to_f
end


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

allRecipes.each do |recipe|

	itemArray = []

	 recipe["ingredientsList_new"].uniq.each do |item|

	 	hasType = allgloss.find{|gloss| gloss["name"] == item}

	 	if !hasType.nil? && !hasType["category"].empty?

	 		itemArray  << {"name" => item.split('%20').map{|word| word.capitalize}.join(' '),"type"=>hasType["category"]}

	 	else

	 		itemArray  << {"name" => item.split('%20').map{|word| word.capitalize}.join(' '),"type"=>[{"level"=>"1", "name"=>"None"}]}

	 	end	

	end

recipe["ingredientsList_new"] = itemArray

recipe["fresh"] = itemArray.select{|item| item["type"][0]["name"] == "Fresh"}.map{|item| item["name"]} 

titleItems = recipe["name"].split(' ').map{|item| item.downcase.singularize }

recipe["must"] =  recipe["fresh"].select {|item| titleItems.select{|inTitle| inTitle.similar(item)>55 }.count> 0}

recipe["fresh"] = recipe["fresh"] - recipe["must"]

end

File.open("/Users/li/Downloads/Script/gitFiles/food/allRecipes_withMust.json","w") do |f|
  f.write(allRecipes.to_json)
end

