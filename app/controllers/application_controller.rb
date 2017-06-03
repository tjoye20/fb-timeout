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

  def user_signed_in?
    redirect_to new_session_path if !current_user
  end 
 
end