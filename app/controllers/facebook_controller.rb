class FacebookController < ApplicationController
  def index

  end
  def show
    @access_token = session["access_token"]
    @graph = Koala::Facebook::API.new(@access_token)
    #@likes = @graph.get_object("me")
    @likes = @graph.get_connections("me", 'feed')
  end
end
