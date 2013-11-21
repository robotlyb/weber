#encoding: utf-8
class Notification < ActiveRecord::Base
  # 被@到的人
  MENTION_REGEXP = /@([a-zA-Z0-9_\-\p{han}]+)/u

  ACTION_MENTION = 'mention'
  ACTION_REPLY = 'reply'
  ACTION_TOPIC = 'topic'
  ACTION_REWARD = 'reward'

  attr_accessible :action, :content

  belongs_to :user

  belongs_to :notificable, :polymorphic => true
  
  belongs_to :action_user, :class => 'User'

  def self.notify(user, notifiable, action_user, action, content)
    nf = Notification.new(:action => action, :content => content)
    nf.notifiable = notifiable
    nf.user = user
    nf.action_user = action_user
    nf.save
  end
end
