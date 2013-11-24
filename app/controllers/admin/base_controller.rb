# encoding: utf-8
class Admin::BaseController < ApplicationController
  layout 'back'

  def method_missing(method)
    if method =~ /^find_parent_(.*)$/
      model = $1.classify.constantize
      instance_variable_set("@#{$1}".to_sym, model.find(params["#{$1}_id".to_sym]))
    elsif method =~ /^find_(.*)$/
      model = $1.classify.constantize
      instance_variable_set("@#{$1}".to_sym, model.find(params[:id]))
    else
      super
    end
  end
end
