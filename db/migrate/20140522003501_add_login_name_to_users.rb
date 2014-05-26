class AddLoginNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_name, :string, limit: 30
    add_index :users, :login_name
  end
end
