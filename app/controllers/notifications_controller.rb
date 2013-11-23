#encoding: utf-8
class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order('created_at DESC').limit(100).all
    current_user.notifications.update_all(:unread => false)
    @unread_count = 0
  end

  def read
  end
end
