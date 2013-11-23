class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :unread, :default => true
      t.integer :notifiable_id
      t.string :notifiable_type
      t.integer :action_user_id

      t.timestamps
    end
  end
end
