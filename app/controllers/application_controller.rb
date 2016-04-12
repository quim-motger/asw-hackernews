class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def hello
    render text: "Hello world! Welcome to our app.\n We are going to have so much fun.\n\n SO\nMUCH"
  end
end
