class CreateSection < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.text :description
      t.integer :prv_section
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
