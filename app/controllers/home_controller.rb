class HomeController < ApplicationController
  layout 'intro'
  def index
  end
  
  def show
    @user = User.find_by_name(params[:member_name])
    render :layout => 'back'
  end
end
