ENV['GOOGLE_CLIENT_ID'] = '889857569941-pob4jfup7pmd6mfhpo3mm40s68ob3345.apps.googleusercontent.com'
ENV['GOOGLE_CLIENT_SECRET'] = 'tao1Bj3dOsajZtbnEsu7Ra7x'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '59440291d2afb9089731', '4d94c86dd6bea0a039d18752c37d594c79fbe639'
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
    scope: ['https://mail.google.com/', 'https://www.googleapis.com/auth/userinfo.email']
  }
end
