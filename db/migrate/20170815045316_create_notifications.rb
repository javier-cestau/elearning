class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :read,  default: 0
      t.references :user, foreign_key: true
      t.datetime :date
      t.string :url
      t.string :message

      t.timestamps
    end
  end
end
