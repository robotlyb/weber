class Assignment < ActiveRecord::Base
  attr_accessible :content, :course_id, :feedback_id, :user_id
end
