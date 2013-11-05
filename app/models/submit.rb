class Submit < ActiveRecord::Base
  attr_accessible :course_id, :position, :user_id
  
  validates :position, :course_id, :user_id, :presence => true 

  belongs_to :course
  belongs_to :user
  
end
