class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable_id, :commentable_type, :user_id

  validates :content, :commentable_id, :commentable_type, :user_id, :presence => true

  belongs_to :user

  #counter_cacha在commentable中有一个comments_count字段
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  
  after_create :send_notifications
  
  def mentioned_users
    mentioned_names = self.content.scan(Notifiable::MENTION_REGEXP).collect {|matched| matched.first}.uniq
    #发表评的人
    mentioned_names.delete(self.user.name)
    #课程发起人
    mentioned_names.delete(self.commentable.user.name)
    mentioned_names.map { |name| User.find_by_name(name) }.compact
  end


  private

    def send_notifications
      # send notification to commentable owner
      # unless the comment was created by the same owner
      # send to commentable's author
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
