Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    member do
      ["do_it", "finish_it", "unfinish_it"].each do |act|
        put act
      end
    end
  end
end
