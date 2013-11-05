class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
      t.integer :user_id
      t.integer :course_id
      t.string :position

      t.timestamps
    end
  end
end
