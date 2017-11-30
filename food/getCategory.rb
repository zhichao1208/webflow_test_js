require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'
require 'iconv'


def getRecipes

# not include all

return data = JSON.parse(File.read('/Users/li/Downloads/Script/gitFiles/food/recipes0-100.json'))

end	

def getCategory (glossary)

	input = Iconv.iconv('ascii//translit', 'utf-8', glossary)[0].to_s.gsub(' ','+')

	uri = URI.parse("https://www.ocado.com//webshop/getSearchProducts.do?clearTabs=yes&isFreshSearch=true&chosenSuggestionPosition=&entry=#{input}&dnr=y")
	response = Net::HTTP.get_response(uri)

	# response.code
	linkItem = {"name"=>glossary,"category"=>[]}

	page = Nokogiri::HTML(response.body)

	list = page.css("ul[id = 'clusters']").css("li")

			list.each do |item|

			linkItem["category"] <<{"level"=> item["class"].split("-")[-1],"name"=>item.text.gsub(/<\/?[^>]*>/, "")}

			end


return linkItem 

end
