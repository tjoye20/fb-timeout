class SessionsController < ApplicationController

  def new
    redirect_to new_mutedphrase_path if current_user
  end

  def failure
    redirect_to root_path, notice: "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :alert => "Logged out!"
  end

end
