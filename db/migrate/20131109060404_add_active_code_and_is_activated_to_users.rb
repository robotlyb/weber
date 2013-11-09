class AddActiveCodeAndIsActivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_code, :string
    add_column :users, :is_activated, :boolean
  end
end
