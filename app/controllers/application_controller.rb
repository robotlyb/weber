# encoding:utf-8
class ApplicationController < ActionController::Base
  require 'debugger'
  protect_from_forgery

  private
  
  def current_user
    @current_user ||= User.find_by_token(cookies[:token]) if cookies[:token]
  end
  
  helper_method :current_user

  def check_admin
    unless current_user && current_user.admin?
      redirect_to :root, :notice => "无权限"
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def auth
    redirect_to root_path if logged_in?
  end

end
