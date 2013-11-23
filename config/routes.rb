#encoding: utf-8
Weber::Application.routes.draw do

  get "session/create"
  
  get "/intro" => "home#index", :as => "intro"

  resources :submits, :feedbacks, :assignments, :comments, :courses
  
  resources :notifications do
    delete :clear, :on => :collection
    get :read, :on => :member
  end

  # 管理员
  namespace :admin do
    resources :courses do
	    get "/download_courseware" => "courses#download_courseware", :as => :download
      # admin course-poster  
      post 'update_poster' => 'courses#update_poster', :as => :update_poster
      # admin course-courseware
      match 'edit_courseware' => 'courses#edit_courseware'
    end
  end

  #邮箱激活
  get '/users(:cad_id,:activate_code)' => 'users#activate_account'
  # 成功页面
  match 'success' => "users#success", :as => :success
  match 'failure' => "users#failure", :as => :failure
	# 编辑edit操作路由
	match '/sign_in' => "sessions#new", :via => :get, :as => :new_session
  match "logout" => "sessions#logout", :as => "logout"
  match '/sign_up' => "users#new", :as => :new_user
	get ':member_name/edit' => 'users#edit', :as => :user_edit
	post '/:member_name/show' => "users#update"
	get '/:member_name' => 'users#show', :as => :user_show
  match '/sessions_path' => "sessions#create", :as => "sessions", :via => :post
  
  get "/:member_name" => "home#show", :as => "member"
  post "/member" => "users#create"

	match "/update_avatar/:member_name" => "users#update_avatar",:as => :update_avatar 
  

  # 课程异步加载
  get "/courses/:course_id/comments" => "comments#index", :as => "comments"
  #get "assignments" => "courses#show", :as => "assignment"

  root :to => 'home#show'
end
