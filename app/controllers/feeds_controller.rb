class FeedsController < ApplicationController
  before_filter :authenticate
  
  def index
    if params[:user] && params[:slug]
      @feed = client.list_timeline(params[:user], params[:slug])
      @title = client.list(params[:user], params[:slug]).name
    else
      @feed = client.home_timeline
      @title = 'Your profile feed'
    end
  end
  
  def dialog
    @tweet = client.status(params[:tweetid])
  end
end
