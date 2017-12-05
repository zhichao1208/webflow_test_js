require 'net/http'
require 'json'
require 'uri'
require_relative  'webflow'
require 'nokogiri'         
require 'open-uri'

site =  Webflow.new()

ingredients = "5a217213bcb0f300016bd804"

recipes = "5a217213bcb0f300016bd7de"


ingredientsIdData = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/ingredients_id_All.json"))

ingredientsIdData = ingredientsIdData.flatten(2)

allRecipes = JSON.parse(File.read("/Users/li/Downloads/Script/gitFiles/food/allRecipes_withMust.json"))

bodys = []

allRecipes.each do |recipe|

	slug = recipe["name"].gsub(' ','')

	recipeName = recipe["name"].split('%20').map{|word| word.capitalize}.join(' ')

	feature = false


# Name

	# number

	if recipe["time"].split(' ')[2] == "hour"

	time =  recipe["time"].split(' ')[1].to_i*60

	else

	time = recipe["time"].split(' ')[1].to_i

	end

# number
rate = recipe["rate"]

# number
vote =  recipe["vote"].split(' ')[0].to_i

# Plain Text
imgurl =  recipe["img"]

# update link

recipe["ingredientsContent"] = recipe["ingredientsContent"].gsub('/article/recipe','/ingredients').gsub('-','').gsub('class="glosslink"','target="_blank"')

# format text

# ingredientslist = mulit Ref
ingredientslist =   recipe["fresh"]

ingredientslistText = (recipe["must"] + recipe["fresh"]).join(',')

ingredientsId =  ingredientslist.map{|item| ingredientsIdData.select{|id| id["name"]== item}[0]["_id"] }

# must = mulit Ref
	if recipe["must"].count == 0

	mustHaveText = 	recipe["fresh"].join(',')

	mustHave = recipe["fresh"].map{|item| ingredientsIdData.select{|id| id["name"]== item}[0]["_id"] }
	else

	mustHaveText = 	recipe["must"].join(',')
	
	mustHave = recipe["must"].map{|item| ingredientsIdData.select{|id| id["name"]== item}[0]["_id"] }
	end

	bodys <<{
		 "fields" => {

					"name"=>recipe["name"],
					"slug"=>slug,
					
		 			"imgurl"=>imgurl,
					"time"=>time,
					"rate"=>rate,
					"vote"=>vote,

					"musthave"=>mustHave,
					"musthave-text"=>mustHaveText,

					"ingredientslist"=>ingredientsId,
					"ingredientslist-text"=>ingredientslistText,

					"ingredients"=>recipe["ingredientsContent"],

					"recipe-description"=>recipe["instructions"],

		  			"_archived" => false,
   			    	 "_draft" => false

					}
		}
break
end

puts bodys[0]["fields"]["ingredientslist-text"]

# puts site.listCollections
=begin
bodys[0..100].each do |body|

puts site.addItem(recipes,body)

sleep 1

puts bodys.index(body)

end	
=end
# puts site.collection(recipes)["fields"].map{|field| '"'+"#{field["slug"]}"+'"'"=>," }


