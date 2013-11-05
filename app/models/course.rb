class Course < ActiveRecord::Base
  attr_accessible :assignment_id, :comments_count, :description, :intro, :public, :title, :user_id

  validates :assignment_id, :description, :intro, :title, :user_id, :presence => true

  has_one :assignment, :dependent => :destroy
  has_many :submits,   :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user

end
