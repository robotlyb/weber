class Feedback < ActiveRecord::Base
  attr_accessible :user_id, :content, :mark, :submit_id

  validates :content, :mark, :presence => true
  belongs_to :submit
  belongs_to :user
end
