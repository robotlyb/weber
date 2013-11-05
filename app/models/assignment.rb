class Assignment < ActiveRecord::Base
  attr_accessible :content, :course_id
  
  validates :content, :presence => :true
  
  belongs_to :course  
end
