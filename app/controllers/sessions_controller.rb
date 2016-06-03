class SessionsController < ApplicationController
    def create
        @userTwitter = UserTwitter.find_or_create_from_auth_hash(auth_hash)
        session[:userTwitter_id] = @userTwitter.id
        redirect_to tweets_path
    end
    
    protected
    
    def auth_hash
        request.env['omniauth.auth']
    end
end