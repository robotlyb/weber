#encoding: utf-8
class CoursesController < ApplicationController
  layout 'back', :only => [:show]

  def show
    @course = Course.find(params[:id])
    # 同步与异步两种
    respond_to do |format|
      #if params[:view] & params[:view] == "course"
      #  @course = "course"
        format.html  
        format.js {render './template/course'}
      #else
    end
  end

end
