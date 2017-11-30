require 'net/http'
require 'json'
require 'nokogiri'         
require 'open-uri'
require 'iconv'

url = "https://www.bigoven.com/glossary"

glossList_withVote = []

page = Nokogiri::HTML(open(url))

title = page.title

links = page.css("a").select{|item| if !item["href"].nil? then item["href"].include?('/article/recipe/') end}


links[10..11].each do |link|

	glossary = link["href"].split('/')[-1]

	puts input = Iconv.iconv('ascii//translit', 'utf-8', glossary)[0].to_s.gsub(' ','+')

	searchUrl = "https://www.tesco.com/groceries/en-GB/search?query=#{input}"

	puts searchPage = Nokogiri::HTML(open(searchUrl))


			puts categorys = page.css("li")

		puts "===="
sleep 1

end

=begin

	voteAll = page.css("div[class = 'upvote-counter left-arrow']")

	if !voteAll.nil? || !voteAll.empty?

	vote = voteAll.map{|vote| vote.text.to_i}.inject(:+)

	else

		vote = 0

	end

	glossList_withVote <<{"name" => glossary,"vote"=>vote}

	

	sleep 1

	puts links.index(link) 
	puts links.count
	puts "------"
end	


File.open("/Users/li/Downloads/Script/gitFiles/food/glossList_withVote.json","w") do |f|
  f.write(glossList_withVote.to_json)
end

=end