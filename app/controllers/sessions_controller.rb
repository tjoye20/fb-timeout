class SessionsController < ApplicationController

  def failure
    redirect_to root_path, notice: "Sorry, but you didn't allow access to our app!"
  end

  def destroy
  	gmail_user.logout
    session[:user_uuid] = nil
    redirect_to root_path, :alert => "Logged out!"
  end

end
