OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, CONFIG[:twitter_key], CONFIG[:twitter_secret]
  provider :github, CONFIG[:github_key], CONFIG[:github_secret]
end
