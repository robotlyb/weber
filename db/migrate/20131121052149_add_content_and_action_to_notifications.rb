class AddContentAndActionToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :content, :text
    add_column :notifications, :action, :string
  end
end
