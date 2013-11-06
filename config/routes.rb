Weber::Application.routes.draw do

  resources :submits


  resources :feedbacks


  resources :assignments


  resources :comments

  resources :courses
	#编辑操作路由
	get '/:member_name/edit' => 'users#edit', :as => :user_edit
	post "/:member_name/edit" => "users#update"
  match '/sign_in' => "sessions#new", :via => :get, :as => :new_session
  match '/sign_up' => "users#new", :as => :new_user
  match '/sessions_path' => "sessions#create", :as => "sessions", :via => :post
  match "logout" => "sessions#logout", :as => "logout"
  
  get "/:member_name" => "users#show", :as => "member"
  post "/member" => "users#create"



  root :to => 'home#index'
end
