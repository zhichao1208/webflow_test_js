
require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'
require 'iconv'

def string_difference_percent(a, b)
  longer = [a.size, b.size].max
  same = a.each_char.zip(b.each_char).select { |a,b| a == b }.size
  (longer - same) / a.size.to_f
end

def getCategory (glossary)

	input = Iconv.iconv('ascii//translit', 'utf-8', glossary)[0].to_s.gsub(' ','+')

	uri = URI.parse("https://www.ocado.com//webshop/getSearchProducts.do?clearTabs=yes&isFreshSearch=true&chosenSuggestionPosition=&entry=#{input}&dnr=y")
	response = Net::HTTP.get_response(uri)

	# response.code
	linkItem = {"name"=>glossary,"category"=>[]}

	page = Nokogiri::HTML(response.body)

	puts noResult = page.css("div[class = 'didYouMean']").text.include?("No results found for")

	if noResult == false

			list = page.css("ul[id = 'clusters']").css("li")

			list.each do |item|

			linkItem["category"] <<{"level"=> item["class"].split("-")[-1],"name"=>item.text.gsub(/<\/?[^>]*>/, "")}

			end
	end

return linkItem 

end


puts string_difference_percent( "chekcken","chicken%20breast")



