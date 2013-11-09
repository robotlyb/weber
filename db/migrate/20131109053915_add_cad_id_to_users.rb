class AddCadIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cad_id, :string
  end
end
