require 'net/http'
require 'uri'
require 'nokogiri'         
require 'open-uri'

require 'active_support/inflector'

puts ["carrots",
"red potatoes",
"mushrooms",
"turnips","red onions"].map{|item| item.singularize }