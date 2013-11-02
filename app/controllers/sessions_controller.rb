class SessionsController < ApplicationController

  layout 'intro', only: [:new]
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.authentication(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Weclome #{@user.name}"
      redirect_to root_path
    else
      flash[:notice] = "The login or password is not correct."
      redirect_to new_session_path
    end
  end

end
