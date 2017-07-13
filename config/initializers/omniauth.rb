Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '59440291d2afb9089731', '4d94c86dd6bea0a039d18752c37d594c79fbe639'
end
