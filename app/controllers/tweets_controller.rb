class TweetsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_loggin?
    respond_to :html

    def index

        @tweets =  current_userTwitter.twitter.user_timeline(current_userTwitter.name) #Tweet.all
        # @tweets.each do |tweet|
        #   tweet.userTwitter_id = current_userTwitter.id;
        # end
        respond_with(@tweets)

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
        redirect_to tweets_path, :notice => "tweet created."

    end

    # def update
    #     @tweet.update(tweet_params)
    #     respond_with(@tweet)
    # end

    def destroy
      # @tweet.destroy
      current_userTwitter.twitter.destroy_status(params[:id])
      redirect_to tweets_path, :notice => "tweet deleted."
      # respond_with(@tweet)
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



end
