# encoding:utf-8
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
require 'debugger'
	layout 'intro', only: [:new]
  before_filter :auth, only: [:new]
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_name(params[:user])
    
    render :layout => 'back'
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
		@user = User.find_by_name(params['member_name'])
		
		render :layout => 'back'

	end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        cookies.permanent[:token] = @user.token
        format.html { redirect_to member_path(@user.name) }
      else
        format.html { render action: "new" }
      end
    end
  end
	
# 映射到edit页面
	def update 
		@user = User.find_by_name(params[:user]['name'])
			respond_to do |format|
				if @user.update_attributes(params[:user])
					format.html { redirect_to user_edit_path(@user.name), notice: "更改成功！"}
					format.json { head :no_content}
				else
					format.html { render action: "edit" }
					format.json {render json: @user.errors, status: :unprocessable_entity}
				end
			end
	end	

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
