Rails.application.routes.draw do

  root "sessions#new"
  resources :sessions, only: [:new, :destroy]

  get '/events', to: "events#index", as: :events 
  get '/create_events', to: "events#create_events", as: :create_events 

  get '/sign-in', to: "sessions#new", as: "sign-in"
  get '/auth/facebook/callback', to: "users#facebook_create"
  get '/auth/google_oauth2/callback', to: "users#google_create"
  get '/logout', to: "sessions#destroy", as: "logout"
  get '/auth/failure', to: "sessions#failure"

end
