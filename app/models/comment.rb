class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable_id, :commentable_type, :user_id

  validates :content, :commentable_id, :commentable_type, :user_id, :presence => true

  belongs_to :user
  belongs_to :commentable, :polymorphic => :true, :couter_cache => true
  
end
