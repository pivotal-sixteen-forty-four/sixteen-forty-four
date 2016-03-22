Rails.application.routes.draw do
  resources :events

  resources :sessions, only: [:new]
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'cards/index'

  root 'cards#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
