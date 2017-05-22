class UsersController < ApplicationController

  def facebook_create
    if params[:denied]
      redirect_to sessions_path
    else
      if !(FacebookUser.find_by(username: auth_hash.info.name))
        @user = FacebookUser.create_user(auth_hash)
      else
        @user = FacebookUser.find_by(username: auth_hash.info.name)
      end
      session[:user_id] = @user.id
      binding.pry 
      redirect_to new_mutedphrase_path
    end
  end

  def google_create
    if params[:denied]
      redirect_to sessions_path
    else
      if !(GoogleUser.find_by(username: auth_hash.info.nickname))
        @user = GoogleUser.create_user(auth_hash, current_user.id)
      else
        @user = GoogleUser.find_by(username: auth_hash.info.nickname)
      end
      session[:user_id] = @user.id
      redirect_to new_mutedphrase_path
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
