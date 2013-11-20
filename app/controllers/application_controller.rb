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
  
  # find *able  
  def method_missing(method, *args, &block)
    if method =~ /^find_(.*)able/
      such_able = "@#{$1}able"
      params.each do |name, value|
        if name =~ /(.+)_id$/
          instance_variable_set(such_able.to_sym, $1.classify.constantize.find(value)) and return
        end
      end
    else
      super
    end
  end
end
