#encoding: utf-8
class Course < ActiveRecord::Base
  attr_accessible :assignment_id, :comments_count, :description, :poster, :intro, :public, :title, :user_id, :courseware

  #validates :assignment_id, :description, :intro, :title, :user_id, :presence => true

  has_one :assignment, :dependent => :destroy
  has_many :submits,   :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :notifications, :as => :notifiable, :dependent => :destroy

  belongs_to :user

  # 仅需返回部分消息
  scope :nav_info, lambda { Course.select(['id', 'title', 'intro', 'poster', 'comments_count', 'created_at']).order("id DESC") }
  # admin课程
  scope :admin_courses, lambda { |admin_id| { 
          :conditions => ['user_id = ?', admin_id]} }

  mount_uploader :poster, PosterUploader
  mount_uploader :courseware, CoursewareUploader


  def courseware_name
    courseware.path.split("/").last
  end

  # 管理员发起的课程
  def self.get_admin_courses(admin_id)
    self.admin_courses(admin_id).nav_info
  end
 
  # 普通用户进入课程界面 
  def self.get_part_of_courses
    self.nav_info
  end

  def public
    public == 1
  end
end
