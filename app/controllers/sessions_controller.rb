class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    log_in(@user)
    redirect_to @user
  end


  def destroy
    log_out
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end