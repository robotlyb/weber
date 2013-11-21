class HomeController < ApplicationController
  require 'debugger'
  layout 'intro'
  def index
  end
  
  def show
    @user = User.find_by_name(params[:member_name])
    @courses = Course.get_part_of_courses

    respond_to do |format|
      format.html { render :layout => 'back' } # index.html.erb
      format.json { render json: @courses }
    end
  end
end
