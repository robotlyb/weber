#encoding: utf-8
Weber::Application.routes.draw do

  get "session/create"

  resources :submits


  resources :feedbacks


  resources :assignments


  resources :comments


  resources :courses
  #邮箱激活
  get '/users(:cad_id,:activate_code)' => 'users#activate_account'
  # 成功页面
  match 'success' => "users#success", :as => :success
  match 'failure' => "users#failure", :as => :failure
	# 编辑edit操作路由
	get ':member_name/edit' => 'users#edit', :as => :user_edit
	post "/:member_name/show" => "users#update"
	get '/:member_name/show' => 'users#show', :as => :user_show
	match '/sign_in' => "sessions#new", :via => :get, :as => :new_session
  match '/sign_up' => "users#new", :as => :new_user
  match '/sessions_path' => "sessions#create", :as => "sessions", :via => :post
  match "logout" => "sessions#logout", :as => "logout"
  
  get "/:member_name" => "home#show", :as => "member"
  post "/member" => "users#create"

  # admin course
  get "/:member_name/courses" => "courses#index" , :as => "admin_courses"
  get "/:member_name/courses/:course_id" => "courses#show" , :as => "show_course"
  get "/:member_name/:course_id/edit" => "courses#edit", :as => "edit_course"
  put "/:member_name/:course_id/update" => "courses#update", :as => "update_course"
  get "/:member_name/course/new" => "courses#new", :as => "new_course"
	match "/update_avatar/:member_name" => "users#update_avatar",:as => :update_avatar 
  # admin course-poster  
  match 'update_poster/:course_id' => 'courses#update_poster', :as => :update_poster
  # admin course-courseware
  match 'edit_courseware/:course_id' => 'courses#edit_courseware'
  
  # normal courses
  get "/:member_name/courses/:course_id" => "courses#show" , :as => "show_course"


  root :to => 'home#index'
end
