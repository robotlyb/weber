class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable_id, :commentable_type, :user_id

  validates :content, :commentable_id, :commentable_type, :user_id, :presence => true

  belongs_to :user

  #counter_cacha在commentable中有一个comments_count字段
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  
  after_create :send_notifications

  private

     def send_notifications
      # send notification to commentable owner
      # unless the comment was created by the same owner
      send_notification_to(
        self.commentable.user,
        Notification::ACTION_REPLY) unless self.user == self.commentable.user
      send_notification_to_mentioned_users
    end

    def send_notification_to(user, action)
      Notification.notify(
        user,
        self.commentable,
        self.user,
        action,
        self.content
      )
    end

    def send_notification_to_mentioned_users
      mentioned_users.each do |user|
        send_notification_to(user, Notification::ACTION_MENTION)
      end
    end
end
