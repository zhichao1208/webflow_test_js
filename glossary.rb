require 'net/http'
require 'uri'
require "open-uri"
require "json"
require 'nokogiri'         


data = JSON.parse(File.read('/Users/li/Downloads/Script/gitFiles/food/glossList.json'))

# glossarys =  data.map{|item| item.values[7..26].reject { |e| e.to_s.empty? }}.flatten.map{|item| item.downcase}.sort.slice_when{|i,j| j!=i}.map{|item| {"name"=>item[0],"count"=>item.count}}

# puts glossarys.sort_by{|item| item["count"]}.reverse

glossarys =  data.map{|item| item["name"]}.flatten!.map{|item| item.downcase}.sort.slice_when{|i,j| j!=i}.map{|item| {"name"=>item[0],"count"=>item.count}}# puts glossarys.sort_by{|item| item["count"]}.reverse

glossarys = glossarys.sort_by{|item| item["count"]}.reverse
