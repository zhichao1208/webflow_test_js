require 'net/http'
require 'uri'
require "open-uri"
require "json"

require "google_drive"


/get and format data/ 
session = GoogleDrive::Session.from_config("config.json")

# food  "1ya7rGBEA-12kXhpSQ4LNzHns2XT_ZDxKeUwmBXx6PtYDzLtbH2Vgk"
files = session.spreadsheet_by_key("12kXhpSQ4LNzHns2XT_ZDxKeUwmBXx6PtYDzLtbH2Vgk").worksheets[0]

title = files.title

filesRows = files.rows

data = JSON.parse(File.read('/Users/li/Downloads/Script/gitFiles/allFood.json'))

keys = data[0].keys

keys.each do |key|

files[2,keys.index(key)+1] = key
files[1,keys.index(key)+1] = keys.index(key)

end

files.save

files.reload


=begin

testUrl = "http://www.themealdb.com/api/json/v1/1/lookup.php?i=52772"
list = "http://www.themealdb.com/api/json/v1/1/list.php?c=list"

uri = URI.parse(list)
response = Net::HTTP.get_response(uri)

# puts JSON.parse(response.body)["meals"][0]

items = []
# response.code
categories =  JSON.parse(response.body)["meals"]

	categories.each do |category|

	puts cat =  category["strCategory"]

	uri = URI.parse("http://www.themealdb.com/api/json/v1/1/filter.php?c=#{cat}")
	
	response = Net::HTTP.get_response(uri)

	items << JSON.parse(response.body)["meals"]

	sleep 1

	puts cat
	end

data = items.flatten

File.open("/Users/li/Downloads/Script/gitFiles/data.json","w") do |f|
  f.write(data.to_json)
end
=end



