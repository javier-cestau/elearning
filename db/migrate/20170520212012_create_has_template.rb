class CreateHasTemplate < ActiveRecord::Migration[5.0]
  def change
    create_table :has_templates do |t|
      t.references :template, foreign_key: true
      t.references :department, foreign_key: true
      t.timestamps
      
    end
  end
end
