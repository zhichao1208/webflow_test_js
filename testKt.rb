require 'net/http'
require 'uri'

uri = URI.parse("https://kitchenstories.io/en/categories/20-minute-dishes?is_ajax=true&page=1")
request = Net::HTTP::Get.new(uri)
request["Accept"] = "*/*"
request["Referer"] = "https://kitchenstories.io/en/categories/20-minute-dishes"
request["X-Requested-With"] = "XMLHttpRequest"
request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# response.code
puts response.body