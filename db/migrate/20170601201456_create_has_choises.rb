class CreateHasChoises < ActiveRecord::Migration[5.0]
  def change
    create_table :has_choises do |t|
      t.references :choise, foreign_key: true
      t.references :response, foreign_key: true

      t.timestamps
    end
  end
end
