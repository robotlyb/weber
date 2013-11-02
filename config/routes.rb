Weber::Application.routes.draw do
  resources :users
  match '/sign_in' => "sessions#new", :via => :get, :as => :new_session
  match '/sessions_path' => "sessions#create", :as => "sessions", :via => :post
  


  root :to => 'home#index'
end
