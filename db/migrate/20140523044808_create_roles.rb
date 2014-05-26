class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 30
      t.string :text, limit: 255

      t.timestamps
    end
  end
end
