require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'

q = "Spicy+Sausage+and+Shrimp+Couscous"

url = "https://www.google.com/search?q=#{q}"

page = Nokogiri::HTML(open(url))

puts title = page.title

 page.css("h3[class = 'r']").each do |item| 
	puts item.css("a")[0]["href"].split('&')[0].split('=')[1]
	puts "---"
	end
