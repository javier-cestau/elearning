class CreateChoises < ActiveRecord::Migration[5.0]
  def change
    create_table :choises do |t|
      t.text :description
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
