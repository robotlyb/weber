class Comment < ActiveRecord::Base
  attr_accessible :content, :course_id, :user_id
end
