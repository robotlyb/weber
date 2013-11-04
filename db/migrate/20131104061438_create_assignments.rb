class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.integer :user_id
      t.text :content
      t.integer :feedback_id

      t.timestamps
    end
  end
end