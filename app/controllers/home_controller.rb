require "koala"
class HomeController < ApplicationController
  def index
    graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
     @likes = graph.get_connections("me", "feeds")
  end
  def show
    graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
    @likes = graph.get_connections("me", "feeds")
  end
end
