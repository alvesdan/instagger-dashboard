OmniAuth.configure do |config|
  config.on_failure do |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
end
