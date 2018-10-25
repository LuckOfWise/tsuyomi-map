Rails.application.routes.draw do

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  resource :mypage, controller: :mypage
  resources :teams, except: %i(index)
  resources :teams, param: :token, only: [] do
    resource :invitations, only: %i(new create)
  end
  root 'home#index'
end
