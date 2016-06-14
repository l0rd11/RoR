class FacebookController < ApplicationController
  before_action :authenticate_user!
  before_action :check_loggin?
  respond_to :html

  def new

  end

  def destroy
    @access_token = session["facebook_access_token"]
    @graph = Koala::Facebook::API.new(@access_token)
    @graph.delete_object(params[:id])
    redirect_to "/facebook", :notice => "Post deleted."
  end

  def create
    if params[:post]
      @access_token = session["facebook_access_token"]
      @graph = Koala::Facebook::API.new(@access_token)
      @graph.put_wall_post(params[:post])
    end
    redirect_to "/facebook", :notice => "Post created."
  end

  def index
    @access_token = session["facebook_access_token"]
    @graph = Koala::Facebook::API.new(@access_token)

    @posts = params[:page] ? @graph.get_page(params[:page]) :@graph.get_connections('me', 'posts')
    @posts.reject!{|p| p["message"].nil?||p["message"].empty?}
    respond_with(@posts)
  end

  def show
    @access_token = session["facebook_access_token"]
    @graph = Koala::Facebook::API.new(@access_token)

    @posts = params[:page] ? @graph.get_page(params[:page]) :@graph.get_connections('me', 'posts')
    @posts.reject!{|p| p["message"].nil?||p["message"].empty?}
    respond_with(@posts)
  end

  private
  def check_loggin?
    if session[:facebook_access_token]
    else
      redirect_to Koala::Facebook::OAuth.new.url_for_oauth_code(:permissions => "publish_actions, public_profile, user_posts", :callback => Rails.application.secrets.facebook_callback_url)
    end

  end
end
