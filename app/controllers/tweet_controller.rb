class TweetsController < ApplicationController
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]
    
    respond_to :html
    
    def index
        @tweets = Tweet.all
        respond_with(@tweets)
    end
    
    def show
        respond_with(@tweets) 
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
        respond_with(@tweet)
    end
    
    def update
        @tweet.update(tweet_params)
        respond_with(@tweet)
    end




end
