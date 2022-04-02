Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    member do
      ["do_it", "finish_it", "unfinish_it"].each do |act|
        put act
      end
    end
  end

  get 'sessions/destroy'
  
  #session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #user
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  resources :users, except: [:new, :create]
end
