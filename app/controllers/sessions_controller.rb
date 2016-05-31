class SessionsController < ApplicationController
  include ApplicationHelper

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    log_in(@user)
    url_redirect = session[:redirect_url]
    session[:redirect_url] = nil
    # print URI.decode_www_form(URI.parse(url_redirect).query) +'AAAAAAAAAAA'
    if url_redirect
      uri = URI.parse(url_redirect)
      query = uri.query
      port = uri.port
      host = uri.host
      unless port == 80
        host=host+':'+port.to_s
      end
      token = 'token='+encode(@user.email)
      if query
        query = '?'+query + '&'+token
      else
        query = '?'+token
      end
      redirect_to 'http://'+host + query
      return
    end
    redirect_to root_url
  end

  def angular_auth
    session[:redirect_url] = params[:redirect_url]
    redirect_to signin_path('google')
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