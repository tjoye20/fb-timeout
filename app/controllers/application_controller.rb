class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= (User.find(session[:user_id]) if session[:user_id])
  end

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = current_user.token
      config.access_token_secret = current_user.secret
    end
  end

  def fb_client(user_access_token)
    Koala.configure do |config|
      config.access_token = user_access_token
      config.app_access_token = ENV["FB_APP_TOKEN"]
      config.app_id = ENV["FB_APP_ID"]
      config.app_secret = ENV["FB_APP_SECRET"]
    end
  end 
end
