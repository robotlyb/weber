class Notification < ActiveRecord::Base
  attr_accessible :action_user_id, :notifiable_id, :notifiable_type, :unread, :user_id
end
