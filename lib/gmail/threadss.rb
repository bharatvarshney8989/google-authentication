require 'googleauth'
require 'google/apis'

class Threadss
	#@@parameters = {fields: "items(alternateLink,description,webContentLink,fileSize,id,mimeType,parents(id,isRoot),title,modifiedDate,owners/displayName, fileSize)"}
	@@google_client_id = '889857569941-pob4jfup7pmd6mfhpo3mm40s68ob3345.apps.googleusercontent.com'
	@@google_client_secret = 'tao1Bj3dOsajZtbnEsu7Ra7x'
	@@OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
	@@scope = 'https://www.googleapis.com/auth/gmail.compose'
	# @@token_store = Google::Auth::Stores::FileTokenStore.

	def initialize(access_token=nil, refresh_token = nil)
		debugger
		@client = Google::Auth::UserAuthorizer.new(@@google_client_id, @@scope, access_token)
		@client.authorization.client_id = @@google_client_id
		@client.authorization.client_secret = @@google_client_secret
		@client.authorization.redirect_uri = "http://localhost:3000/auth/google_oauth2/callback"
		@access_token = access_token
		if access_token.nil?
			@client.authorization.grant_type = 'refresh_token'
			@client.authorization.refresh_token = refresh_token
			request = @client.authorization.fetch_access_token!
			@access_token = request["access_token"]
		end
		@client.authorization.access_token = @access_token
		@gmail_api = @client.discovered_api('gmail', 'v1')
	end
end
