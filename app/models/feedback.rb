class Feedback < ActiveRecord::Base
  attr_accessible :assignment_id, :content, :mark
end
