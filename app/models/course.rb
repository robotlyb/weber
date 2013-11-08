#encoding: utf-8
class Course < ActiveRecord::Base
  attr_accessible :assignment_id, :comments_count, :description, :poster, :intro, :public, :title, :user_id, :courseware

  #validates :assignment_id, :description, :intro, :title, :user_id, :presence => true

  has_one :assignment, :dependent => :destroy
  has_many :submits,   :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user

  # 仅需返回部分消息
  scope :nav_info, lambda { Course.select(['id', 'title', 'intro', 'poster', 'comments_count', 'created_at']) }
  # admin课程
  scope :admin_courses, lambda { |admin_id| { 
          :conditions => ['user_id = ?', admin_id], :order => 'id DESC' } }

  mount_uploader :poster, PosterUploader
  mount_uploader :courseware, CoursewareUploader


  def courseware_name
    courseware.path.split("/").last
  end
  def self.get_admin_courses(admin_id)
    self.admin_courses(admin_id).nav_info
  end

  def public
    public == 1
  end

end
