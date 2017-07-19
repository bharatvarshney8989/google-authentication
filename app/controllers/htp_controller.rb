require 'net/http'
require 'net/https'
require 'uri'
require 'google/api_client/client_secrets'
require 'google/apis/gmail_v1'
require 'googleauth/stores/file_token_store'
require 'googleauth'

SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY
OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Gmail API Ruby Quickstart'

class HtpController < ApplicationController
      def create
        byebug
        client_id = "889857569941-pob4jfup7pmd6mfhpo3mm40s68ob3345.apps.googleusercontent.com"
         client_secret1 = "tao1Bj3dOsajZtbnEsu7Ra7x"

         #uri = URI('https://accounts.google.com/o/oauth2/token')
         #http = Net::HTTP.new(uri.host, uri.port)
        client_secrets = Google::APIClient::ClientSecrets.load( File.join( Rails.root, 'config', 'client_secret.json' ) )
         @auth_client = client_secrets.to_authorization
          api_access_token_obj = OAuth2::AccessToken.new(@auth_client, ENV['GA_OAUTH_ACCESS_TOKEN'])
          token_store = Google::Auth::Stores::FileTokenStore.new(file:  File.join( Rails.root, 'config', 'client_secrets.json' ))
          authorizer = Google::Auth::UserAuthorizer.new(
            client_id, SCOPE, token_store)
             user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +"resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials


            #uri = URI('https://accounts.google.com/o/oauth2/token')
            #http = Net::HTTP.new(uri.host, uri.port)
             #http.use_ssl = true
             #http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            #request = Net::HTTP::Post.new(uri.request_uri)
            #byebug
            #request.set_form_data('code' => api_access_token_obj, 'client_id' => client_id, 'client_secret' => client_secret1, 'grant_type' => 'authorization_code')
            #request.content_type = 'application/x-www-form-urlencoded'
            #response = http.request(request)
            #access_keys = ActiveSupport::JSON.decode(response.body)




      end
end
