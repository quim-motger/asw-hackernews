class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def record_not_found
    render :file => "public/404.html", :status => 404
  end

  def hello
    render text: "Hello world! Welcome to our app.\n We are going to have so much fun.\n\n SO\nMUCH"
  end

  protected

  def authenticate
    if request.authorization and user = User.find_by_email(decode(request.authorization))
      @api_user = user
    else
      request_http_token_authentication
    end
  end

end
