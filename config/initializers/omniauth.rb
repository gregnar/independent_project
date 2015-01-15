Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :goodreads, Figaro.env.goodreads_key, Figaro.env.goodreads_secret
end
