class NewsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_loggin?, :check_loggin_facebook?, :init
    respond_to :html
   
    def init
        @access_token = session["facebook_access_token"]
        @graph = Koala::Facebook::API.new(@access_token)
    end
     
    def index
    end

    def show

    end

    def new
       @tweet = Tweet.new
       respond_with(@tweet)
    end

    def edit
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.userTwitter_id = current_userTwitter.id
        @tweet.save
        if params[:tweet][:body]
            @graph.put_wall_post(params[:tweet][:body])
        end
        redirect_to '/', :notice => "Post created"

    end


    def destroy
    end

    private
    def check_loggin?
        if current_userTwitter
        else
          redirect_to root_path + 'auth/twitter'
        end
    end
    def set_tweet
        if params[:method] != "delete"
          @tweet = Tweet.find(params[:id])
        end

    end

    def tweet_params
        params.require(:tweet).permit(:user_id, :body)
    end
    private
    def check_loggin_facebook?
        if session[:facebook_access_token]
        else
        redirect_to Koala::Facebook::OAuth.new.url_for_oauth_code(:permissions => "publish_actions, public_profile, user_posts", :callback => Rails.application.secrets.facebook_callback_url)
        end
    end



end
