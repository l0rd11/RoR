class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_filter :parse_facebook_cookies
  def parse_facebook_cookies
    @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end

end
