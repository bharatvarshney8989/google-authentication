Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '59440291d2afb9089731', '4d94c86dd6bea0a039d18752c37d594c79fbe639'
  provider :google_oauth2, '889857569941-pob4jfup7pmd6mfhpo3mm40s68ob3345.apps.googleusercontent.com', 'tao1Bj3dOsajZtbnEsu7Ra7x',{client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

end
