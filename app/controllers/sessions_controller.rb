class SessionsController < ApplicationController
  def new
  end

  def create
    
    require 'oauth'

    consumer = get_consumer

    # Get a request token from Twitter
    @request_token = consumer.get_request_token :oauth_callback => ('http://' + request.env['HTTP_HOST'] + '/oauth/')

    # Store the request token's details for later
    session[:request_token] = @request_token.token
    session[:request_secret] = @request_token.secret

    # Hand off to Twitter so the user can authorize us
    redirect_to @request_token.authorize_url
    
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def oauth
    
    if session[:request_token] == nil || session[:request_secret] == nil
      redirect_to new_session_path
    end
    
    require 'oauth'

    consumer = get_consumer

    # Re-create the request token
    @request_token = OAuth::RequestToken.new(consumer,
        session[:request_token], session[:request_secret])

    # Convert the request token to an access token using the verifier Twitter gave us
    @access_token = @request_token.get_access_token(:oauth_verifier =>
        params[:oauth_verifier])

    reset_session

    # Store the token and secret that we need to make API calls
    session[:oauth_token] = @access_token.token
    session[:oauth_secret] = @access_token.secret

    sign_in(client.verify_credentials)
    redirect_back_or root_path
  end
  
  private

    def get_consumer
      OAuth::Consumer.new(
        'zWA8b9gi71sJ4genJfpQ',
        'ePHbq6JK7iYic4XC1T9yiXtad37utVdZZLPGNQJHRk',
        {:site => 'http://api.twitter.com', :scheme => :header}
      )
    end
end
