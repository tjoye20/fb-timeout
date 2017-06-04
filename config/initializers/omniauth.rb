Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_APP_ID"], ENV["FB_APP_SECRET"],
  scope: "user_events"
  provider :google_oauth2, ENV["GOOGLE_API_ID"], ENV["GOOGLE_API_SECRET"],
  scope: "calendar"
end
