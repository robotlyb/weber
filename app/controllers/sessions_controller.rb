class SessionsController < ApplicationController

  layout 'intro', only: [:new]
  before_filter :auth, only: [:new]

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
      cookies.permanent[:token] = @user.token
      flash[:notice] = "Weclome #{@user.name}"
      redirect_to member_path(@user.name)
    else
      flash[:notice] = "The login or password is not correct."
      redirect_to new_session_path
    end
  end

  def logout
    cookies.delete(:token)
    redirect_to root_url
  end

end
