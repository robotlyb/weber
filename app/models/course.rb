class Course < ActiveRecord::Base
  attr_accessible :assignment_id, :comments_count, :description, :intro, :public, :tittle, :user_id
end
