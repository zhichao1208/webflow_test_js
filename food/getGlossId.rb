require 'net/http'
require 'json'
require 'uri'
require_relative  'webflow'
require 'open-uri'


site =  Webflow.new()

ingredients = "5a217213bcb0f300016bd804"

recipes = "5a217213bcb0f300016bd7de"

dataJson = []

for i in [0,100,200,300,400]

dataJson << site.itemsOfCollectionWithOffset(ingredients,100,i)["items"]

sleep 1

end	

File.open("/Users/li/Downloads/Script/gitFiles/food/ingredients_id_All.json","w") do |f|
  f.write(dataJson.to_json)
end
