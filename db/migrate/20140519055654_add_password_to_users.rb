class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, limit: 60
  end
end
