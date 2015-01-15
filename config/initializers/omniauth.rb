Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # provider :goodreads, ENV['KEY'], ENV['SECRET']
end
