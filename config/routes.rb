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

  #registration
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  resources :registrations, except: [:new, :create]

  #user
  namespace :admin do
    resources :users
  end
end
