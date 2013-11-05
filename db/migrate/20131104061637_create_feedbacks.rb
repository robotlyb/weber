class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :submit_id
      t.integer :user_id
      t.text :content
      t.integer :mark

      t.timestamps
    end
  end
end
