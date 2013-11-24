#encoding: utf-8
class NotificationsController < ApplicationController
  require 'debugger'
  layout 'back'
  def index
    # 有待重构，不用每次都加载页头的提醒数量
    # 1.显示在通知页面的是所有存在于数据表notifications中的该用户的数据
    # 2.显示在导航栏的数字是改用户尚未查看过的消息数量，每次点击会清零
    @notifications = current_user.total_notifications.order('created_at DESC').limit(100).all
    current_user.notifications.update_all(:unread => false)
    @total_notifications = current_user.total_notifications.size
  end

  # 有待重构，同时更新数量 
  def destroy
    # ajax请求删除一条通知记录
    @notification = Notification.find(params[:id])
    @ele = "nf-" + @notification.id.to_s
    @notification.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

  def clear
    @notifications = current_user.total_notifications.order('created_at DESC')
    @notifications.each do |notification|
      notification.destroy
    end

    respond_to do |format|
      format.html { redirect_to notifications_path }
    end
  end
end
