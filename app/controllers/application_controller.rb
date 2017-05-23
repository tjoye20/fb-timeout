class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= (FacebookUser.find(session[:user_id]) if session[:user_id])
  end


  def fb_client
    Koala::Facebook::API.new(current_user.token)
  end 

  def google_client
    google_user = GoogleUser.find_by(facebook_user_id: current_user.id) 
    @client = Google::APIClient.new
    @client.authorization.access_token = google_user.token
    @client.authorization.refresh_token = google_user.refresh_token
    @client.authorization.client_id = ENV['GOOGLE_API_ID']
    @client.authorization.client_secret = ENV['GOOGLE_API_SECRET']
    @client.authorization.refresh!
    @service = @client.discovered_api('calendar', 'v3')
  end 
end