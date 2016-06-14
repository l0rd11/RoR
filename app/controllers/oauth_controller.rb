class OauthController < ApplicationController
  def redirect
    session[:facebook_access_token] = Koala::Facebook::OAuth.new(Rails.application.secrets.facebook_callback_url).get_access_token(params[:code]) if params[:code]

    redirect_to session[:facebook_access_token] ? '/facebook' : '/'
  end
end