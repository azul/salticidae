Salticidae::Application.routes.draw do

  get "sign_up" => "users#new", :as => "sign_up"
  resources :users

  root :to => "home#index"

end
