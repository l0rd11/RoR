class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_userTwitter
    @current_userTwitter ||= UserTwitter.find(session[:userTwitter_id]) if session[:userTwitter_id]
  end
  helper_method :current_userTwitter
  
end
