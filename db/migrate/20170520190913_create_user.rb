class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :privilege
      t.string :email
      t.string :encrypted_password
      t.string :reset_password_token
      t.date :reset_password_sent_at
      t.date :remember_created_at
      t.integer :sign_in_count
      t.date :current_sign_in_at
      t.date :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
      t.string :uid
      t.string :provider
      t.string :position
      t.string :management
      t.string :name
      t.integer :state , default: 1
      t.attachment :photo      
      t.timestamps
    end
    add_index :users, :email
    add_index :users, :reset_password_token
  end
end
