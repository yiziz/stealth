class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|

      t.string :mailer, limit: 30
      t.string :action, limit: 30
      t.text :target
      t.text :options
      t.boolean :sent, default: false
      t.timestamp :sent_on

      t.index :sent

      t.timestamps
    end
  end
end
