class UsersController < ApplicationController
  before_action :set_user, only: [:new, :create]

  def facebook_create
    if params[:denied]
      redirect_to sessions_path
    else
      if !FacebookUser.find_by(username: auth_hash.info.name)
       @user = FacebookUser.create_user(auth_hash)
      else
        @user = FacebookUser.find_by(username: auth_hash.info.name)
      end
      session[:user_uuid] = @user.uuid
      redirect_to create_events_path
    end
  end

  def google_create
    if params[:denied]
      redirect_to sessions_path
    else
      if !GoogleUser.find_by(email: auth_hash.info.email)
        GoogleUser.create_user(auth_hash, current_user.id)
      else
        GoogleUser.find_by(email: auth_hash.info.email)
      end
      redirect_to events_path
    end
  end


  def create 
    binding.pry 
  end 

  private 

  def set_user 
    @user = current_user
  end 

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
