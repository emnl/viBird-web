class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  protect_from_forgery
  
  def client
    Twitter.configure do |config|
      config.consumer_key = 'zWA8b9gi71sJ4genJfpQ'
      config.consumer_secret = 'ePHbq6JK7iYic4XC1T9yiXtad37utVdZZLPGNQJHRk'
      config.oauth_token = session[:oauth_token]
      config.oauth_token_secret = session[:oauth_secret]
    end

    # Initialize your Twitter client
    client = Twitter::Client.new
  end
  
  def current_user
    session[:screen_name] if signed_in?
  end
end