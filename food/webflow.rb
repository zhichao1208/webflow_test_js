
#encoding: utf-8
require 'net/http'
require 'json'
require 'uri'

$client_id ="8b3f797e01a5b3658bfc61663a768200fe86956d4b27dbfc1c6b0679a0fc1ce8"
$client_secret = "b663a4cd91dfe9091dd56bc89e8857e62795fa134ae9296318176ebf5aaba65e"
$code = "be7669cb15ae4acee15f66ca01420ec7ab18e3eca11410dd850f3676198ccd6b"
$access_token = "38c0da9b3e0e33ee7f0834ef45f25d53e888e752e2e678014c87816978f3851b"
$site_id = "5a1c0a186b2f3a0001d695fb"

class Webflow

			def getIt(uri)

			request = Net::HTTP::Get.new(uri)
			request["Authorization"] = "Bearer #{$access_token}"
			request["Accept-Version"] = "1.0.0"

			req_options = {
			  use_ssl: uri.scheme == "https",
			}

			response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			  http.request(request)
			end

			# response.code
			return JSON.parse(response.body)

			end


			def updateIt(uri,body)

			request = Net::HTTP::Put.new(uri)
		request.content_type = "application/json"
		request["Authorization"] = "Bearer #{$access_token}"
		request["Accept-Version"] = "1.0.0"
		request.body = JSON.dump(body)

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end

		# response.code
			return JSON.parse(response.body)
		

			end	

		def addIt(uri,body)

					request = Net::HTTP::Post.new(uri)
		request.content_type = "application/json"
		request["Authorization"] = "Bearer #{$access_token}"
		request["Accept-Version"] = "1.0.0"
		request.body = JSON.dump(body)

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end
		# response.code
		# response.body
			return JSON.parse(response.body)
		

			end	



	def requestAccessToken
		uri = URI.parse("https://api.webflow.com/oauth/access_token")
		request = Net::HTTP::Post.new(uri)
		request.set_form_data(
	  "client_id" => $client_id,
	  "client_secret" => $client_secret,
	  "code" => $code,
	  "grant_type" => "authorization_code",
	)

		req_options = {
	  use_ssl: uri.scheme == "https",
	}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
	  http.request(request)
	end

# response.code
    return response.body

	end		


	def geCurrentAuthorizationInfo
	uri = URI.parse("https://api.webflow.com/info")
		return getIt(uri)


	end


	def listSites
		uri = URI.parse("https://api.webflow.com/sites")
		return getIt(uri)

		end

	def listCollections

		uri = URI.parse("https://api.webflow.com/sites/#{$site_id}/collections")
		return getIt(uri)


		end
	
	def collection(collection_id)

		uri = URI.parse("https://api.webflow.com/collections/#{collection_id}")
		return getIt(uri)

	end	


	def itemsOfCollection(collection_id,n)

		uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items?limit=#{n}")
		return getIt(uri)

	end	

	def getItem(collection_id,item_id)

		uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items/#{item_id}")
		return getIt(uri)

	end	

	def addItem(collection_id,body)
			uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items")

			return addIt(uri,body)

	end

	def addLiveItem(collection_id,body)
			uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items?live=true")

			return addIt(uri,body)

	end	

	def updateItem(collection_id,item_id,body)
		
		uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items/#{item_id}")

		return updateIt(uri,body)

			end

	def deleteItem(collection_id,item_id,body)
			uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items/#{item_id}")

			request = Net::HTTP::Delete.new(uri)
			request["Authorization"] = "Bearer #{$access_token}"
			request["Accept-Version"] = "1.0.0"

			req_options = {
			  use_ssl: uri.scheme == "https",
			}

			response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			  http.request(request)
			end

		return JSON.parse(response.body)
	end

	def itemsOfCollectionWithOffset(collection_id,limit,offset)

		uri = URI.parse("https://api.webflow.com/collections/#{collection_id}/items?limit=#{limit}&offset=#{offset}")
		return getIt(uri)

	end	

end
