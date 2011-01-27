class ListsController < ApplicationController
  before_filter :authenticate
  
  def index
    @sublists = client.subscriptions(current_user)[:lists]
    @mylists = client.lists()[:lists]
  end
end
