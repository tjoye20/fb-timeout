Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"]
  provider :facebook, ENV["FB_APP_ID"], ENV["FB_APP_SECRET"],
  scope: "user_events,manage_pages,pages_show_list,rsvp_event"
  provider :google_oauth2, ENV["GOOGLE_API_ID"], ENV["GOOGLE_API_SECRET"],
  scope: "calendar"
end
