class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :email
      t.string :password_digest
      t.string :token
      t.integer :admin
      t.string :name
      t.string :password_reset_token
      t.string :password_reset_sent_at

      t.timestamps
    end
  end
end
