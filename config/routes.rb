Vibird::Application.routes.draw do

  resources :sessions
  match "oauth" => "sessions#oauth"
  match "login" => "sessions#new"
  match "logout" => "sessions#destroy"
  
  match "lists" => "lists#index"
  match "feed" => "feeds#index"
  match "dialog" => "feeds#dialog"

  root :to => "feeds#index"

end
