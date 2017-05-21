class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= (FacebookUser.find(session[:user_id]) if session[:user_id])
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
