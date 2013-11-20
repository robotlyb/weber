#encoding: utf-8
class CoursesController < ApplicationController
  require 'debugger'
  before_filter :check_admin, :only => [:edit]
  layout 'back', :only => [:index, :new, :show, :edit]
  def index
    # 查找管理员所发布的课程
    @courses = Course.get_admin_courses(current_user.id)

    respond_to do |format|
     format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find_by_id(params[:course_id])
    # 同步与异步两种
    respond_to do |format|
      if params[:view] == "course"
        @course = "course"
        format.js {render './template/course'}
      else
        format.html  
      end
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:course_id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to edit_course_path(current_user.name, @course.id), notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    debugger
    @course = Course.where(:user_id => current_user.id, :title => params[:course][:title]).first
    if @course.assignment_id.blank?
      assignment = Assignment.new(params[:assignment])
      assignment.course_id = @course.id
    else
      assignment = @course.assignment 
      assignment.update_attributes(params[:assignment])
    end
    assignment.save
    @course.assignment_id = assignment.id

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to show_course_url(current_user.name, @course.id)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def update_poster
    @course = Course.find(params[:course_id])
    respond_to do |format|
      format.js do
        @course.update_attributes(params[:course])
      end
    end
  end

  def edit_courseware
    @course = Course.find(params[:course_id])
    respond_to do |format|
      format.js do
        @course.update_attributes(params[:cc])
      end
    end
  end

	# download the courseware
	def download_courseware
		@course = Course.find_by_courseware(params[:courseware])
		respond_to do |format|
			format.js do
				send_file("/uploads/courseware/#{@course.courseware}", filename: "#{@course.courseware}")
			end
		end
	end
end
