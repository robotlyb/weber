# encoding: utf-8
class Admin::CoursesController < Admin::BaseController
  require 'debugger'
  before_filter :check_admin, :only => [:edit]
  layout 'back', :only => [:index, :new, :show, :edit]

  def index
    # 查找管理员所发布的课程
    @courses = Course.get_admin_courses(current_user.id)

    respond_to do |format|
      format.html
      format.json { render json: @courses }
    end
  end

   def new
     @course = Course.new

     respond_to do |format|
       format.html # new.html.erb
       format.json { render json: @courses }
     end
   end

  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to edit_admin_course_path(@course), notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def update
    @course = Course.find(params[:id])
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
        format.html { redirect_to course_path(@course)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
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
