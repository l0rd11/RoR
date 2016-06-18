class FacebookController < ApplicationController
  before_action :authenticate_user!
  before_action :check_loggin?, :init#, check_loggin_twitter?
  respond_to :html

  def init
    @access_token = session["facebook_access_token"]
    @graph = Koala::Facebook::API.new(@access_token)
  end

  def new

  end

  def destroy

    @graph.delete_object(params[:id])
    redirect_to "/facebook", :notice => "Post deleted."
  end

  def create
    if params[:post]
      @graph.put_wall_post(params[:post])
    end
    redirect_to "/facebook", :notice => "Post created."
  end
  def tweet_params
        params.require(:tweet).permit(:user_id, :post)
  end

  def index
    @respond = {}
    @posts = params[:page] ? @graph.get_page(params[:page]) : @graph.get_connections('me', 'posts')
    @posts.reject! { |p| p["message"].nil?||p["message"].empty? }
    @posts.each { |post| @coments =@graph.get_connections(post["id"], 'comments')
      @coments.reject! { |p| p["message"].nil?||p["message"].empty? }
      @respond[post]=@coments
    }

    respond_with(@respond)
  end

  def show
    @respond = {}
    @posts = params[:page] ? @graph.get_page(params[:page]) : @graph.get_connections('me', 'posts')
    @posts.reject! { |p| p["message"].nil?||p["message"].empty? }
    @posts.each { |post| @coments =@graph.get_connections(post["id"], 'comments')
    @coments.reject! { |p| p["message"].nil?||p["message"].empty? }
    @respond[post]=@coments
    }
    respond_with(@respond)
  end

  # def new_comment
  #   @post_id = params[:post_id]
  # end
  #
  # def comment
  #   @graph.put_comment(@post_id, params[:comment])
  #   redirect_to "/facebook", :notice => "Post comented."
  # end

  private
  def check_loggin?
  
    if session[:facebook_access_token]
    else
      redirect_to Koala::Facebook::OAuth.new.url_for_oauth_code(:permissions => "publish_actions, public_profile, user_posts", :callback => Rails.application.secrets.facebook_callback_url)
    end

  end
end
