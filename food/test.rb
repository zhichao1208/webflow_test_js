require 'net/http'
require 'uri'
require 'nokogiri'         
require 'open-uri'

require 'active_support/inflector'

require_relative 'getCategory'

item =  getRecipes[0]["ingredientsList"][0]

# singlar 

puts item.pluralize(2)
