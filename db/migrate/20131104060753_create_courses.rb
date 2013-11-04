class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :tittle
      t.string :intro
      t.text :description
      t.boolean :public
      t.integer :comments_count
      t.integer :user_id
      t.integer :assignment_id

      t.timestamps
    end
  end
end