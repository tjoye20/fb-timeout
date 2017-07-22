class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= (FacebookUser.find_by(uuid: session[:user_uuid]) if session[:user_uuid])
  end


  def fb_client
    Koala::Facebook::API.new(current_user.token)
  end 

  def user_signed_in?
    redirect_to new_session_path if !current_user
  end 
 
  def gmail_user
    Gmail.connect(:xoauth2, current_user.google_user.email, current_user.google_user.token)
  end 
end